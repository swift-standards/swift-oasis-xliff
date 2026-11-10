import W3C_XML

extension XLIFF.Reader {

    func inline(
        _ element: W3C_XML::W3C_XML.Element,
        scope: XLIFF.Scope,
        codes: Bool
    ) throws(XLIFF.Error) -> [XLIFF.Inline] {
        var result: [XLIFF.Inline] = []
        for item in element.content {
            switch item {
            case .text(let text), .cdata(let text):
                if case .text(let previous) = result.last {
                    result[result.index(before: result.endIndex)] = .text(previous + text)
                } else {
                    result.append(.text(text))
                }

            case .comment, .instruction:
                break

            case .element(let child):
                let childScope = scope.adding(child.namespaces)
                guard try childScope.isCore(child) else {
                    throw .unexpectedElement(child.name.qualified, in: element.name.local)
                }
                if child.name.local == "cp" {
                    result.append(.codePoint(try codePoint(child, scope: childScope)))
                } else if codes {
                    result.append(try code(child, scope: childScope, in: element.name.local))
                } else {
                    throw .unexpectedElement(child.name.qualified, in: element.name.local)
                }
            }
        }
        return result
    }

    func codePoint(_ element: W3C_XML::W3C_XML.Element, scope: XLIFF.Scope) throws(XLIFF.Error) -> XLIFF.CodePoint {
        var attributes = try Attributes(element, scope: scope)
        let hex = try attributes.required("hex")
        try attributes.finish()
        try empty(element)
        guard let point = XLIFF.CodePoint(hex: hex) else {
            throw .invalidValue(hex, attribute: "hex", on: "cp")
        }
        return point
    }

    func empty(_ element: W3C_XML::W3C_XML.Element) throws(XLIFF.Error) {
        for item in element.content {
            switch item {
            case .element(let child):
                throw .unexpectedElement(child.name.qualified, in: element.name.local)

            case .text(let text), .cdata(let text):
                guard text.isEmpty else { throw .unexpectedText(in: element.name.local) }

            case .comment, .instruction:
                break
            }
        }
    }

    func code(_ element: W3C_XML::W3C_XML.Element, scope: XLIFF.Scope, in parent: String) throws(XLIFF.Error) -> XLIFF.Inline {
        var attributes = try Attributes(element, scope: scope)
        let declarations = Self.declarations(element)
        switch element.name.local {
        case "ph":
            try empty(element)
            return .standalone(
                XLIFF.Code.Standalone(
                    id: try XLIFF.Identifier(attributes.required("id")),
                    canCopy: try attributes.boolean("canCopy"),
                    canDelete: try attributes.boolean("canDelete"),
                    canReorder: try attributes.value("canReorder", as: XLIFF.Code.Reorder.self),
                    copyOf: attributes.identifier("copyOf"),
                    display: attributes.string("disp"),
                    equivalent: attributes.string("equiv"),
                    data: attributes.identifier("dataRef"),
                    subFlows: attributes.identifiers("subFlows"),
                    type: try attributes.value("type", as: XLIFF.Code.Kind.self),
                    subType: attributes.string("subType"),
                    extensions: try attributes.extensions(declarations)
                )
            )

        case "pc":
            return .spanning(
                XLIFF.Code.Spanning(
                    id: try XLIFF.Identifier(attributes.required("id")),
                    canCopy: try attributes.boolean("canCopy"),
                    canDelete: try attributes.boolean("canDelete"),
                    canOverlap: try attributes.boolean("canOverlap"),
                    canReorder: try attributes.value("canReorder", as: XLIFF.Code.Reorder.self),
                    copyOf: attributes.identifier("copyOf"),
                    displayStart: attributes.string("dispStart"),
                    displayEnd: attributes.string("dispEnd"),
                    equivalentStart: attributes.string("equivStart"),
                    equivalentEnd: attributes.string("equivEnd"),
                    dataStart: attributes.identifier("dataRefStart"),
                    dataEnd: attributes.identifier("dataRefEnd"),
                    subFlowsStart: attributes.identifiers("subFlowsStart"),
                    subFlowsEnd: attributes.identifiers("subFlowsEnd"),
                    type: try attributes.value("type", as: XLIFF.Code.Kind.self),
                    subType: attributes.string("subType"),
                    direction: try attributes.value("dir", as: XLIFF.Direction.self),
                    extensions: try attributes.extensions(declarations),
                    content: try inline(element, scope: scope, codes: true)
                )
            )

        case "sc":
            try empty(element)
            return .start(
                XLIFF.Code.Start(
                    id: try XLIFF.Identifier(attributes.required("id")),
                    isolated: try attributes.boolean("isolated"),
                    canCopy: try attributes.boolean("canCopy"),
                    canDelete: try attributes.boolean("canDelete"),
                    canOverlap: try attributes.boolean("canOverlap"),
                    canReorder: try attributes.value("canReorder", as: XLIFF.Code.Reorder.self),
                    copyOf: attributes.identifier("copyOf"),
                    display: attributes.string("disp"),
                    equivalent: attributes.string("equiv"),
                    data: attributes.identifier("dataRef"),
                    subFlows: attributes.identifiers("subFlows"),
                    type: try attributes.value("type", as: XLIFF.Code.Kind.self),
                    subType: attributes.string("subType"),
                    direction: try attributes.value("dir", as: XLIFF.Direction.self),
                    extensions: try attributes.extensions(declarations)
                )
            )

        case "ec":
            try empty(element)
            return .end(
                XLIFF.Code.End(
                    id: attributes.identifier("id"),
                    startReference: attributes.identifier("startRef"),
                    isolated: try attributes.boolean("isolated"),
                    canCopy: try attributes.boolean("canCopy"),
                    canDelete: try attributes.boolean("canDelete"),
                    canOverlap: try attributes.boolean("canOverlap"),
                    canReorder: try attributes.value("canReorder", as: XLIFF.Code.Reorder.self),
                    copyOf: attributes.identifier("copyOf"),
                    display: attributes.string("disp"),
                    equivalent: attributes.string("equiv"),
                    data: attributes.identifier("dataRef"),
                    subFlows: attributes.identifiers("subFlows"),
                    type: try attributes.value("type", as: XLIFF.Code.Kind.self),
                    subType: attributes.string("subType"),
                    direction: try attributes.value("dir", as: XLIFF.Direction.self),
                    extensions: try attributes.extensions(declarations)
                )
            )

        case "mrk":
            return .annotation(
                XLIFF.Annotation(
                    id: try XLIFF.Identifier(attributes.required("id")),
                    translate: try attributes.boolean("translate"),
                    type: attributes.string("type").map(XLIFF.Annotation.Kind.init(rawValue:)),
                    reference: attributes.string("ref"),
                    value: attributes.string("value"),
                    extensions: try attributes.extensions(declarations),
                    content: try inline(element, scope: scope, codes: true)
                )
            )

        case "sm":
            try empty(element)
            return .annotationStart(
                XLIFF.Annotation.Start(
                    id: try XLIFF.Identifier(attributes.required("id")),
                    translate: try attributes.boolean("translate"),
                    type: attributes.string("type").map(XLIFF.Annotation.Kind.init(rawValue:)),
                    reference: attributes.string("ref"),
                    value: attributes.string("value"),
                    extensions: try attributes.extensions(declarations)
                )
            )

        case "em":
            try empty(element)
            let reference = try XLIFF.Identifier(attributes.required("startRef"))
            try attributes.finish()
            return .annotationEnd(XLIFF.Annotation.End(startReference: reference))

        default:
            throw .unexpectedElement(element.name.qualified, in: parent)
        }
    }
}
