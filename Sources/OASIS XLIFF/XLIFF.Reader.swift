import BCP_47
import RFC_3987
import W3C_XML

extension XLIFF {

    struct Reader {}
}

extension XLIFF.Reader {

    func document(_ xml: W3C_XML::W3C_XML.Document) throws(XLIFF.Error) -> XLIFF.Document {
        let root = xml.root
        let scope = XLIFF.Scope().adding(root.namespaces)
        guard try scope.isCore(root), root.name.local == "xliff" else {
            throw .unexpectedRoot(root.name.qualified)
        }
        var attributes = try Attributes(root, scope: scope)
        let versionValue = try attributes.required("version")
        guard let version = XLIFF.Version(rawValue: versionValue) else {
            throw .invalidValue(versionValue, attribute: "version", on: "xliff")
        }
        let sourceValue = try attributes.required("srcLang")
        guard let sourceLanguage = try attributes.language(sourceValue, attribute: "srcLang") else {
            throw .missingAttribute("srcLang", on: "xliff")
        }
        let targetLanguage = try attributes.language(attributes.string("trgLang"), attribute: "trgLang")
        let space = try attributes.space()
        let language = try attributes.xmlLanguage()
        let extensions = try attributes.extensions(Self.declarations(root))
        var files: [XLIFF.File] = []
        for child in try structural(root, scope: scope) {
            guard try scope.adding(child.namespaces).isCore(child), child.name.local == "file" else {
                throw .unexpectedElement(child.name.qualified, in: "xliff")
            }
            files.append(try file(child, scope: scope))
        }
        return XLIFF.Document(
            version: version,
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage,
            space: space,
            language: language,
            extensions: extensions,
            files: files,
            prologue: xml.prologue,
            epilogue: xml.epilogue
        )
    }
}

extension XLIFF.Reader {

    static func declarations(_ element: W3C_XML::W3C_XML.Element) -> [W3C_XML::W3C_XML.Namespace] {
        element.namespaces.filter { $0.prefix != nil }
    }

    func structural(_ element: W3C_XML::W3C_XML.Element, scope: XLIFF.Scope) throws(XLIFF.Error) -> [W3C_XML::W3C_XML.Element] {
        var result: [W3C_XML::W3C_XML.Element] = []
        for item in element.content {
            switch item {
            case .element(let child):
                result.append(child)

            case .text(let text), .cdata(let text):
                guard text.utf8.allSatisfy(XLIFF.isWhitespace) else {
                    throw .unexpectedText(in: element.name.local)
                }

            case .comment, .instruction:
                break
            }
        }
        return result
    }

    func file(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> XLIFF.File {
        let scope = outer.adding(element.namespaces)
        var attributes = try Attributes(element, scope: scope)
        let id = try XLIFF.Identifier(attributes.required("id"))
        let original = try attributes.reference("original")
        let canResegment = try attributes.boolean("canResegment")
        let translate = try attributes.boolean("translate")
        let sourceDirection = try attributes.value("srcDir", as: XLIFF.Direction.self)
        let targetDirection = try attributes.value("trgDir", as: XLIFF.Direction.self)
        let space = try attributes.space()
        let language = try attributes.xmlLanguage()
        var extensions = try attributes.extensions(Self.declarations(element))
        var skeleton: XLIFF.Skeleton?
        var notes: [XLIFF.Note] = []
        var nodes: [XLIFF.Node] = []
        var phase = 0
        for child in try structural(element, scope: scope) {
            let childScope = scope.adding(child.namespaces)
            guard try childScope.isCore(child) else {
                guard phase <= 1 else { throw .unexpectedElement(child.name.qualified, in: "file") }
                phase = 1
                extensions.elements.append(scope.selfContained(child))
                continue
            }
            switch child.name.local {
            case "skeleton" where phase == 0:
                phase = 1
                skeleton = try self.skeleton(child, scope: scope)

            case "notes" where phase <= 1:
                phase = 2
                notes = try self.notes(child, scope: scope)

            case "unit":
                phase = 3
                nodes.append(.unit(try unit(child, scope: scope)))

            case "group":
                phase = 3
                nodes.append(.group(try group(child, scope: scope)))

            default:
                throw .unexpectedElement(child.name.qualified, in: "file")
            }
        }
        return XLIFF.File(
            id: id,
            original: original,
            canResegment: canResegment,
            translate: translate,
            sourceDirection: sourceDirection,
            targetDirection: targetDirection,
            space: space,
            language: language,
            skeleton: skeleton,
            extensions: extensions,
            notes: notes,
            nodes: nodes
        )
    }

    func skeleton(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> XLIFF.Skeleton {
        let scope = outer.adding(element.namespaces)
        var attributes = try Attributes(element, scope: scope)
        let href = try attributes.reference("href")
        try attributes.finish()
        var content: [W3C_XML::W3C_XML.Content] = []
        for item in element.content {
            switch item {
            case .element(let child):
                guard try !scope.adding(child.namespaces).isCore(child) else {
                    throw .unexpectedElement(child.name.qualified, in: "skeleton")
                }
                content.append(.element(scope.selfContained(child)))

            case .text(let text), .cdata(let text):
                if case .text(let previous) = content.last {
                    content[content.index(before: content.endIndex)] = .text(previous + text)
                } else {
                    content.append(.text(text))
                }

            case .comment, .instruction:
                break
            }
        }
        return XLIFF.Skeleton(href: href, namespaces: Self.declarations(element), content: content)
    }

    func group(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> XLIFF.Group {
        let scope = outer.adding(element.namespaces)
        var attributes = try Attributes(element, scope: scope)
        let id = try XLIFF.Identifier(attributes.required("id"))
        let name = attributes.string("name")
        let canResegment = try attributes.boolean("canResegment")
        let translate = try attributes.boolean("translate")
        let sourceDirection = try attributes.value("srcDir", as: XLIFF.Direction.self)
        let targetDirection = try attributes.value("trgDir", as: XLIFF.Direction.self)
        let type = attributes.string("type")
        let space = try attributes.space()
        let language = try attributes.xmlLanguage()
        var extensions = try attributes.extensions(Self.declarations(element))
        var notes: [XLIFF.Note] = []
        var nodes: [XLIFF.Node] = []
        var phase = 0
        for child in try structural(element, scope: scope) {
            guard try scope.adding(child.namespaces).isCore(child) else {
                guard phase == 0 else { throw .unexpectedElement(child.name.qualified, in: "group") }
                extensions.elements.append(scope.selfContained(child))
                continue
            }
            switch child.name.local {
            case "notes" where phase == 0:
                phase = 1
                notes = try self.notes(child, scope: scope)

            case "unit":
                phase = 2
                nodes.append(.unit(try unit(child, scope: scope)))

            case "group":
                phase = 2
                nodes.append(.group(try group(child, scope: scope)))

            default:
                throw .unexpectedElement(child.name.qualified, in: "group")
            }
        }
        return XLIFF.Group(
            id: id,
            name: name,
            canResegment: canResegment,
            translate: translate,
            sourceDirection: sourceDirection,
            targetDirection: targetDirection,
            space: space,
            language: language,
            type: type,
            extensions: extensions,
            notes: notes,
            nodes: nodes
        )
    }

    func unit(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> XLIFF.Unit {
        let scope = outer.adding(element.namespaces)
        var attributes = try Attributes(element, scope: scope)
        let id = try XLIFF.Identifier(attributes.required("id"))
        let name = attributes.string("name")
        let canResegment = try attributes.boolean("canResegment")
        let translate = try attributes.boolean("translate")
        let sourceDirection = try attributes.value("srcDir", as: XLIFF.Direction.self)
        let targetDirection = try attributes.value("trgDir", as: XLIFF.Direction.self)
        let type = attributes.string("type")
        let space = try attributes.space()
        let language = try attributes.xmlLanguage()
        var extensions = try attributes.extensions(Self.declarations(element))
        var notes: [XLIFF.Note] = []
        var originalData: [XLIFF.Data] = []
        var parts: [XLIFF.Unit.Part] = []
        var phase = 0
        for child in try structural(element, scope: scope) {
            guard try scope.adding(child.namespaces).isCore(child) else {
                guard phase == 0 else { throw .unexpectedElement(child.name.qualified, in: "unit") }
                extensions.elements.append(scope.selfContained(child))
                continue
            }
            switch child.name.local {
            case "notes" where phase == 0:
                phase = 1
                notes = try self.notes(child, scope: scope)

            case "originalData" where phase <= 1:
                phase = 2
                originalData = try self.originalData(child, scope: scope)

            case "segment":
                phase = 3
                parts.append(.segment(try segment(child, scope: scope)))

            case "ignorable":
                phase = 3
                parts.append(.ignorable(try ignorable(child, scope: scope)))

            default:
                throw .unexpectedElement(child.name.qualified, in: "unit")
            }
        }
        return XLIFF.Unit(
            id: id,
            name: name,
            canResegment: canResegment,
            translate: translate,
            sourceDirection: sourceDirection,
            targetDirection: targetDirection,
            space: space,
            language: language,
            type: type,
            extensions: extensions,
            notes: notes,
            originalData: originalData,
            parts: parts
        )
    }

    func notes(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> [XLIFF.Note] {
        let scope = outer.adding(element.namespaces)
        try Attributes(element, scope: scope).finish()
        var result: [XLIFF.Note] = []
        for child in try structural(element, scope: scope) {
            guard try scope.adding(child.namespaces).isCore(child), child.name.local == "note" else {
                throw .unexpectedElement(child.name.qualified, in: "notes")
            }
            result.append(try note(child, scope: scope, inherited: Self.declarations(element)))
        }
        guard !result.isEmpty else { throw .missingElement("note", in: "notes") }
        return result
    }

    func note(
        _ element: W3C_XML::W3C_XML.Element,
        scope outer: XLIFF.Scope,
        inherited: [W3C_XML::W3C_XML.Namespace]
    ) throws(XLIFF.Error) -> XLIFF.Note {
        let scope = outer.adding(element.namespaces)
        var attributes = try Attributes(element, scope: scope)
        let id = attributes.identifier("id")
        let subject = try attributes.value("appliesTo", as: XLIFF.Note.Subject.self)
        let category = attributes.string("category")
        let priority = try attributes.integer("priority")
        let extensions = try attributes.extensions(inherited + Self.declarations(element))
        return XLIFF.Note(
            try text(element),
            id: id,
            subject: subject,
            category: category,
            priority: priority,
            extensions: extensions
        )
    }

    func text(_ element: W3C_XML::W3C_XML.Element) throws(XLIFF.Error) -> String {
        var result = ""
        for item in element.content {
            switch item {
            case .text(let text), .cdata(let text):
                result += text

            case .element(let child):
                throw .unexpectedElement(child.name.qualified, in: element.name.local)

            case .comment, .instruction:
                break
            }
        }
        return result
    }

    func originalData(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> [XLIFF.Data] {
        let scope = outer.adding(element.namespaces)
        try Attributes(element, scope: scope).finish()
        var result: [XLIFF.Data] = []
        for child in try structural(element, scope: scope) {
            guard try scope.adding(child.namespaces).isCore(child), child.name.local == "data" else {
                throw .unexpectedElement(child.name.qualified, in: "originalData")
            }
            let childScope = scope.adding(child.namespaces)
            var attributes = try Attributes(child, scope: childScope)
            let id = try XLIFF.Identifier(attributes.required("id"))
            let direction = try attributes.value("dir", as: XLIFF.Direction.self)
            let space = try attributes.space()
            try attributes.finish()
            result.append(
                XLIFF.Data(
                    id: id,
                    direction: direction,
                    space: space,
                    namespaces: Self.declarations(element) + Self.declarations(child),
                    content: try inline(child, scope: childScope, codes: false)
                )
            )
        }
        guard !result.isEmpty else { throw .missingElement("data", in: "originalData") }
        return result
    }

    func segment(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> XLIFF.Segment {
        let scope = outer.adding(element.namespaces)
        var attributes = try Attributes(element, scope: scope)
        let id = attributes.identifier("id")
        let canResegment = try attributes.boolean("canResegment")
        let state = try attributes.value("state", as: XLIFF.State.self)
        let subState = attributes.string("subState")
        try attributes.finish()
        let (source, target) = try pair(element, scope: scope)
        return XLIFF.Segment(
            id: id,
            canResegment: canResegment,
            state: state,
            subState: subState,
            namespaces: Self.declarations(element),
            source: source,
            target: target
        )
    }

    func ignorable(_ element: W3C_XML::W3C_XML.Element, scope outer: XLIFF.Scope) throws(XLIFF.Error) -> XLIFF.Ignorable {
        let scope = outer.adding(element.namespaces)
        var attributes = try Attributes(element, scope: scope)
        let id = attributes.identifier("id")
        try attributes.finish()
        let (source, target) = try pair(element, scope: scope)
        return XLIFF.Ignorable(id: id, namespaces: Self.declarations(element), source: source, target: target)
    }

    func pair(
        _ element: W3C_XML::W3C_XML.Element,
        scope: XLIFF.Scope
    ) throws(XLIFF.Error) -> (XLIFF.Source, XLIFF.Target?) {
        var source: XLIFF.Source?
        var target: XLIFF.Target?
        for child in try structural(element, scope: scope) {
            let childScope = scope.adding(child.namespaces)
            guard try childScope.isCore(child) else {
                throw .unexpectedElement(child.name.qualified, in: element.name.local)
            }
            switch child.name.local {
            case "source" where source == nil:
                var attributes = try Attributes(child, scope: childScope)
                let language = try attributes.xmlLanguage()
                let space = try attributes.space()
                try attributes.finish()
                source = XLIFF.Source(
                    language: language,
                    space: space,
                    namespaces: Self.declarations(child),
                    content: try inline(child, scope: childScope, codes: true)
                )

            case "target" where source != nil && target == nil:
                var attributes = try Attributes(child, scope: childScope)
                let language = try attributes.xmlLanguage()
                let space = try attributes.space()
                let order = try attributes.integer("order")
                try attributes.finish()
                target = XLIFF.Target(
                    language: language,
                    space: space,
                    order: order,
                    namespaces: Self.declarations(child),
                    content: try inline(child, scope: childScope, codes: true)
                )

            default:
                throw .unexpectedElement(child.name.qualified, in: element.name.local)
            }
        }
        guard let source else { throw .missingElement("source", in: element.name.local) }
        return (source, target)
    }
}

extension XLIFF {

    static func isWhitespace(_ byte: UInt8) -> Bool {
        byte == 0x20 || byte == 0x09 || byte == 0x0A || byte == 0x0D
    }
}
