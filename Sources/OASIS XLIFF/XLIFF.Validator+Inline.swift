import W3C_XML

extension XLIFF.Validator {

    func inline(
        _ content: [XLIFF.Inline],
        scope: XLIFF.Scope,
        unit: XLIFF.Unit,
        context: Context
    ) throws(XLIFF.Error) {
        for item in content {
            switch item {
            case .text:
                break

            case .codePoint(let point):
                try codePoint(point)

            case .standalone(let code):
                try self.code(
                    code.id,
                    element: "ph",
                    extensions: code.extensions,
                    scope: scope,
                    canCopy: code.canCopy,
                    canDelete: code.canDelete,
                    canReorder: code.canReorder,
                    type: code.type,
                    subType: code.subType,
                    copied: code.copyOf != nil && code.data != nil
                )
                try text(code.display, in: "ph")
                try text(code.equivalent, in: "ph")

            case .spanning(let code):
                try self.code(
                    code.id,
                    element: "pc",
                    extensions: code.extensions,
                    scope: scope,
                    canCopy: code.canCopy,
                    canDelete: code.canDelete,
                    canReorder: code.canReorder,
                    type: code.type,
                    subType: code.subType,
                    copied: code.copyOf != nil && (code.dataStart != nil || code.dataEnd != nil)
                )
                for value in [code.displayStart, code.displayEnd, code.equivalentStart, code.equivalentEnd] {
                    try text(value, in: "pc")
                }
                try paired(code.dataStart != nil, code.dataEnd != nil, "dataRefStart", "dataRefEnd")
                try paired(code.equivalentStart != nil, code.equivalentEnd != nil, "equivStart", "equivEnd")
                try inline(
                    code.content,
                    scope: scope.adding(code.extensions.namespaces),
                    unit: unit,
                    context: context
                )

            case .start(let code):
                try self.code(
                    code.id,
                    element: "sc",
                    extensions: code.extensions,
                    scope: scope,
                    canCopy: code.canCopy,
                    canDelete: code.canDelete,
                    canReorder: code.canReorder,
                    type: code.type,
                    subType: code.subType,
                    copied: code.copyOf != nil && code.data != nil
                )
                try text(code.display, in: "sc")
                try text(code.equivalent, in: "sc")

            case .end(let code):
                if let reference = code.startReference {
                    try identifier(reference, on: "ec")
                }
                try self.code(
                    code.id ?? code.startReference,
                    element: "ec",
                    extensions: code.extensions,
                    scope: scope,
                    canCopy: code.canCopy,
                    canDelete: code.canDelete,
                    canReorder: code.canReorder,
                    type: code.type,
                    subType: code.subType,
                    copied: code.copyOf != nil && code.data != nil
                )
                try text(code.display, in: "ec")
                try text(code.equivalent, in: "ec")

            case .annotation(let annotation):
                try self.annotation(
                    annotation.id,
                    element: "mrk",
                    type: annotation.type,
                    reference: annotation.reference,
                    value: annotation.value,
                    extensions: annotation.extensions,
                    scope: scope,
                    unit: unit,
                    context: context
                )
                try inline(
                    annotation.content,
                    scope: scope.adding(annotation.extensions.namespaces),
                    unit: unit,
                    context: context
                )

            case .annotationStart(let annotation):
                try self.annotation(
                    annotation.id,
                    element: "sm",
                    type: annotation.type,
                    reference: annotation.reference,
                    value: annotation.value,
                    extensions: annotation.extensions,
                    scope: scope,
                    unit: unit,
                    context: context
                )

            case .annotationEnd(let annotation):
                try identifier(annotation.startReference, on: "em")
            }
        }
    }

    func paired(_ first: Bool, _ second: Bool, _ firstName: String, _ secondName: String) throws(XLIFF.Error) {
        guard first == second else {
            throw .unpairedAttribute(first ? firstName : secondName, on: "pc")
        }
    }

    func code(
        _ id: XLIFF.Identifier?,
        element: String,
        extensions: XLIFF.Extensions,
        scope: XLIFF.Scope,
        canCopy: Bool?,
        canDelete: Bool?,
        canReorder: XLIFF.Code.Reorder?,
        type: XLIFF.Code.Kind?,
        subType: String?,
        copied: Bool
    ) throws(XLIFF.Error) {
        if let id {
            try identifier(id, on: element)
        }
        let id = id ?? ""
        try attributes(extensions, on: element, scope: scope, allowed: .code)
        if let child = extensions.elements.first {
            throw .unexpectedElement(child.name.qualified, in: element)
        }
        if canReorder == .no || canReorder == .firstNo {
            guard canCopy == false, canDelete == false else { throw .invalidHints(id) }
        }
        if copied {
            throw .copiedCodeWithData(id)
        }
        if let subType {
            guard let type else { throw .subTypeWithoutType(id) }
            guard let parts = qualified(subType) else {
                throw .invalidValue(subType, attribute: "subType", on: element)
            }
            if parts.prefix == "xlf" {
                switch parts.value {
                case "b", "i", "u", "lb", "pb":
                    guard type == .fmt else { throw .typeMismatch(id) }

                case "var":
                    guard type == .ui else { throw .typeMismatch(id) }

                default:
                    throw .invalidValue(subType, attribute: "subType", on: element)
                }
            }
        }
    }

    func annotation(
        _ id: XLIFF.Identifier,
        element: String,
        type: XLIFF.Annotation.Kind?,
        reference: String?,
        value: String?,
        extensions: XLIFF.Extensions,
        scope: XLIFF.Scope,
        unit: XLIFF.Unit,
        context: Context
    ) throws(XLIFF.Error) {
        try identifier(id, on: element)
        try attributes(extensions, on: element, scope: scope, allowed: .annotation)
        if let child = extensions.elements.first {
            throw .unexpectedElement(child.name.qualified, in: element)
        }
        try text(reference, in: element)
        try text(value, in: element)
        if case .custom(let custom) = type {
            guard qualified(custom) != nil else {
                throw .invalidValue(custom, attribute: "type", on: element)
            }
            if custom == "mtc:match", reference != nil {
                throw .unexpectedAttribute("ref", on: element)
            }
        }
        var fragment: XLIFF.Fragment?
        if let reference, reference.hasPrefix("#") {
            let parsed = try XLIFF.Fragment(parsing: reference)
            if let prefix = parsed.selectors.last?.prefix, prefix.count > 1,
                !XLIFF.Namespace.fragmentPrefixes.contains(prefix), prefixes[prefix] == nil
            {
                throw .invalidFragment(reference)
            }
            fragment = parsed
        }
        guard type == .comment else { return }
        guard (value == nil) != (reference == nil) else { throw .invalidCommentAnnotation(id) }
        guard reference != nil else { return }
        guard let fragment, fragment.selectors.last?.prefix == "n", let note = fragment.selector("n") else {
            throw .invalidCommentAnnotation(id)
        }
        let structural = fragment.selectors.filter { ["f", "g", "u"].contains($0.prefix ?? "") }
        if !structural.isEmpty {
            guard fragment.selector("u") == unit.id,
                fragment.selector("f").map({ $0 == context.file }) ?? true,
                fragment.selector("g").map(context.groups.contains) ?? true
            else { throw .invalidCommentAnnotation(id) }
        }
        guard unit.notes.contains(where: { $0.id == note }) else {
            throw .unknownReference(note, attribute: "ref")
        }
    }
}
