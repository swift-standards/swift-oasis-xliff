import BCP_47
import W3C_XML

extension XLIFF.Document {

    public func validate(prefixes: [String: String] = [:]) throws(XLIFF.Error) {
        try XLIFF.Validator(document: self, prefixes: prefixes).validate()
    }
}

extension XLIFF {

    struct Validator {

        let document: XLIFF.Document

        let prefixes: [String: String]
    }
}

extension XLIFF.Validator {

    func validate() throws(XLIFF.Error) {
        guard !document.files.isEmpty else { throw .missingElement("file", in: "xliff") }
        let scope = XLIFF.Scope().adding(document.extensions.namespaces)
        if let element = document.extensions.elements.first {
            throw .unexpectedElement(element.name.qualified, in: "xliff")
        }
        try attributes(document.extensions, on: "xliff", scope: scope, allowed: .any)
        let hasTarget = document.units.contains { unit in unit.parts.contains { $0.target != nil } }
        if hasTarget, document.targetLanguage == nil {
            throw .missingTargetLanguage
        }
        var files: Set<XLIFF.Identifier> = []
        for file in document.files {
            try identifier(file.id, on: "file")
            guard files.insert(file.id).inserted else {
                throw .duplicateIdentifier(file.id, element: "file")
            }
            try self.file(file, scope: scope)
        }
    }

    func file(_ file: XLIFF.File, scope outer: XLIFF.Scope) throws(XLIFF.Error) {
        let scope = outer.adding(file.extensions.namespaces)
        guard !file.nodes.isEmpty else { throw .missingElement("unit", in: "file") }
        if let skeleton = file.skeleton {
            guard (skeleton.href == nil) != skeleton.content.isEmpty else { throw .invalidSkeleton }
            for item in skeleton.content {
                if case .element(let element) = item,
                    try scope.adding(skeleton.namespaces).adding(element.namespaces).isCore(element)
                {
                    throw .unexpectedElement(element.name.qualified, in: "skeleton")
                }
            }
        }
        try attributes(file.extensions, on: "file", scope: scope, allowed: .any)
        try elements(file.extensions, at: .file, scope: scope)
        try notes(file.notes, scope: scope)
        var groups: Set<XLIFF.Identifier> = []
        var units: Set<XLIFF.Identifier> = []
        try collect(file.nodes, groups: &groups, units: &units)
        let context = Context(
            scope: scope,
            language: file.language ?? document.language,
            file: file.id,
            groups: [],
            units: units
        )
        for node in file.nodes {
            try self.node(node, context: context)
        }
    }

    func collect(
        _ nodes: [XLIFF.Node],
        groups: inout Set<XLIFF.Identifier>,
        units: inout Set<XLIFF.Identifier>
    ) throws(XLIFF.Error) {
        for node in nodes {
            switch node {
            case .unit(let unit):
                try identifier(unit.id, on: "unit")
                guard units.insert(unit.id).inserted else {
                    throw .duplicateIdentifier(unit.id, element: "unit")
                }

            case .group(let group):
                try identifier(group.id, on: "group")
                guard groups.insert(group.id).inserted else {
                    throw .duplicateIdentifier(group.id, element: "group")
                }
                try collect(group.nodes, groups: &groups, units: &units)
            }
        }
    }

    func node(_ node: XLIFF.Node, context: Context) throws(XLIFF.Error) {
        switch node {
        case .unit(let unit):
            try self.unit(unit, context: context)

        case .group(let group):
            var inner = context
            inner.scope = context.scope.adding(group.extensions.namespaces)
            inner.language = group.language ?? context.language
            inner.groups.append(group.id)
            try text(group.name, in: "group")
            try structuralType(group.type, on: "group")
            try attributes(group.extensions, on: "group", scope: inner.scope, allowed: .any)
            try elements(group.extensions, at: .group, scope: inner.scope)
            try notes(group.notes, scope: inner.scope)
            for child in group.nodes {
                try self.node(child, context: inner)
            }
        }
    }
}

extension XLIFF.Validator {

    func identifier(_ id: XLIFF.Identifier, on element: String) throws(XLIFF.Error) {
        guard id.isToken else { throw .invalidValue(id.value, attribute: "id", on: element) }
    }

    func text(_ value: String?, in element: String) throws(XLIFF.Error) {
        guard let value else { return }
        guard XLIFF.scalars(value).allSatisfy(W3C_XML::W3C_XML.isChar) else {
            throw .invalidCharacter(in: element)
        }
    }

    func qualified(_ value: String) -> (prefix: Substring, value: Substring)? {
        guard let colon = value.firstIndex(of: ":") else { return nil }
        let prefix = value[..<colon]
        let rest = value[value.index(after: colon)...]
        guard !prefix.isEmpty, !rest.isEmpty,
            !prefix.utf8.contains(where: XLIFF.isWhitespace),
            !rest.utf8.contains(where: XLIFF.isWhitespace)
        else { return nil }
        return (prefix, rest)
    }

    func structuralType(_ type: String?, on element: String) throws(XLIFF.Error) {
        guard let type else { return }
        guard let parts = qualified(type), parts.prefix != "xlf" else {
            throw .invalidValue(type, attribute: "type", on: element)
        }
    }

    func attributes(
        _ extensions: XLIFF.Extensions,
        on element: String,
        scope outer: XLIFF.Scope,
        allowed: Allowed
    ) throws(XLIFF.Error) {
        let scope = outer.adding(extensions.namespaces)
        for attribute in extensions.attributes {
            try text(attribute.value, in: element)
            let namespace = try scope.attribute(attribute.name)
            let permitted: Bool
            switch (allowed, namespace) {
            case (_, nil), (_, XLIFF.Namespace.core?):
                permitted = false

            case (.any, _):
                permitted = true

            case (.annotation, let uri?):
                permitted = uri != XLIFF.Namespace.xml

            case (.code, let uri?):
                permitted = XLIFF.Namespace.codeAttributes.contains(uri)

            case (.none, _):
                permitted = false
            }
            guard permitted else {
                throw .unexpectedAttribute(attribute.name.qualified, on: element)
            }
        }
    }

    func elements(
        _ extensions: XLIFF.Extensions,
        at point: XLIFF.Namespace.Point,
        scope: XLIFF.Scope
    ) throws(XLIFF.Error) {
        let modules = XLIFF.Namespace.moduleElements(at: point)
        let name =
            switch point {
            case .file: "file"
            case .group: "group"
            case .unit: "unit"
            }
        var counts: [String: Int] = [:]
        var identifiers: Set<String> = []
        for element in extensions.elements {
            let elementScope = scope.adding(element.namespaces)
            guard let namespace = try elementScope.element(element.name), namespace != XLIFF.Namespace.core else {
                throw .unexpectedElement(element.name.qualified, in: name)
            }
            if let allowed = modules[namespace] {
                guard let limit = allowed[element.name.local] else {
                    throw .unexpectedElement(element.name.qualified, in: name)
                }
                let key = namespace + " " + element.name.local
                counts[key, default: 0] += 1
                if let limit, let count = counts[key], count > limit {
                    throw .unexpectedElement(element.name.qualified, in: name)
                }
            } else {
                try extensionIdentifiers(element, into: &identifiers)
            }
        }
    }

    func extensionIdentifiers(_ element: W3C_XML::W3C_XML.Element, into identifiers: inout Set<String>) throws(XLIFF.Error) {
        for attribute in element.attributes
        where (attribute.name.prefix == nil && attribute.name.local == "id")
            || (attribute.name.prefix == "xml" && attribute.name.local == "id")
        {
            guard identifiers.insert(attribute.value).inserted else {
                throw .duplicateIdentifier(XLIFF.Identifier(attribute.value), element: element.name.qualified)
            }
        }
        for child in element.children {
            try extensionIdentifiers(child, into: &identifiers)
        }
    }

    func notes(_ notes: [XLIFF.Note], scope: XLIFF.Scope) throws(XLIFF.Error) {
        var identifiers: Set<XLIFF.Identifier> = []
        for note in notes {
            try text(note.text, in: "note")
            try text(note.category, in: "note")
            if let id = note.id {
                try identifier(id, on: "note")
                guard identifiers.insert(id).inserted else {
                    throw .duplicateIdentifier(id, element: "note")
                }
            }
            if let priority = note.priority, !(1...10).contains(priority) {
                throw .invalidValue(String(priority), attribute: "priority", on: "note")
            }
            try attributes(note.extensions, on: "note", scope: scope, allowed: .any)
            if let element = note.extensions.elements.first {
                throw .unexpectedElement(element.name.qualified, in: "note")
            }
        }
    }

    func matches(_ lhs: BCP47.LanguageTag, _ rhs: BCP47.LanguageTag) -> Bool {
        lhs.value.lowercased() == rhs.value.lowercased()
    }
}
