import BCP_47
import W3C_XML

extension XLIFF.Validator {

    func unit(_ unit: XLIFF.Unit, context: Context) throws(XLIFF.Error) {
        let scope = context.scope.adding(unit.extensions.namespaces)
        let language = unit.language ?? context.language
        try text(unit.name, in: "unit")
        try structuralType(unit.type, on: "unit")
        try attributes(unit.extensions, on: "unit", scope: scope, allowed: .any)
        try elements(unit.extensions, at: .unit, scope: scope)
        try notes(unit.notes, scope: scope)
        guard unit.parts.contains(where: { if case .segment = $0 { true } else { false } }) else {
            throw .missingElement("segment", in: "unit")
        }
        var data: Set<XLIFF.Identifier> = []
        for item in unit.originalData {
            try identifier(item.id, on: "data")
            guard data.insert(item.id).inserted else {
                throw .duplicateIdentifier(item.id, element: "data")
            }
            if item.space == .default {
                throw .invalidValue(XLIFF.Space.default.description, attribute: "xml:space", on: "data")
            }
            for piece in item.content {
                switch piece {
                case .text:
                    break

                case .codePoint(let point):
                    try codePoint(point)

                default:
                    throw .unexpectedElement(Self.identity(piece)?.element ?? "inline", in: "data")
                }
            }
        }
        for part in unit.parts {
            try self.part(part, unit: unit, scope: scope, language: language, context: context)
        }
        let sources = unit.parts.flatMap { Self.flattened($0.source.content) }
        let targets = unit.parts.flatMap { Self.flattened($0.target?.content ?? []) }
        try pairing(sources)
        try pairing(targets)
        try references(unit, data: data, context: context)
        try hints(unit)
        try identifiers(unit)
        try order(unit)
    }

    func part(
        _ part: XLIFF.Unit.Part,
        unit: XLIFF.Unit,
        scope outer: XLIFF.Scope,
        language: BCP47.LanguageTag?,
        context: Context
    ) throws(XLIFF.Error) {
        let element: String
        let namespaces: [W3C_XML::W3C_XML.Namespace]
        switch part {
        case .segment(let segment):
            element = "segment"
            namespaces = segment.namespaces
            if let subState = segment.subState {
                guard segment.state != nil else { throw .subStateWithoutState }
                guard qualified(subState) != nil else {
                    throw .invalidValue(subState, attribute: "subState", on: "segment")
                }
            }
            if let state = segment.state, state != .initial, segment.target == nil {
                throw .stateWithoutTarget(state)
            }

        case .ignorable(let ignorable):
            element = "ignorable"
            namespaces = ignorable.namespaces
        }
        if let id = part.id {
            try identifier(id, on: element)
        }
        let scope = outer.adding(namespaces)
        let source = part.source
        let sourceLanguage = source.language ?? language ?? document.sourceLanguage
        guard matches(sourceLanguage, document.sourceLanguage) else {
            throw .languageMismatch(
                element: "source",
                expected: document.sourceLanguage.value,
                found: sourceLanguage.value
            )
        }
        try inline(source.content, scope: scope.adding(source.namespaces), unit: unit, context: context)
        if let target = part.target {
            guard let expected = document.targetLanguage else { throw .missingTargetLanguage }
            let targetLanguage = target.language ?? language ?? expected
            guard matches(targetLanguage, expected) else {
                throw .languageMismatch(element: "target", expected: expected.value, found: targetLanguage.value)
            }
            try inline(target.content, scope: scope.adding(target.namespaces), unit: unit, context: context)
        }
    }

    func codePoint(_ point: XLIFF.CodePoint) throws(XLIFF.Error) {
        guard point.isEncodable else {
            throw .invalidValue(point.hex, attribute: "hex", on: "cp")
        }
    }
}

extension XLIFF.Validator {

    static func identity(_ inline: XLIFF.Inline) -> (id: XLIFF.Identifier, element: String)? {
        switch inline {
        case .standalone(let code): (code.id, "ph")
        case .spanning(let code): (code.id, "pc")
        case .start(let code): (code.id, "sc")
        case .end(let code): code.id.map { ($0, "ec") }
        case .annotation(let annotation): (annotation.id, "mrk")
        case .annotationStart(let annotation): (annotation.id, "sm")
        case .text, .codePoint, .annotationEnd: nil
        }
    }

    static func flattened(_ content: [XLIFF.Inline]) -> [XLIFF.Inline] {
        var result: [XLIFF.Inline] = []
        for item in content {
            result.append(item)
            switch item {
            case .spanning(let code): result += flattened(code.content)
            case .annotation(let annotation): result += flattened(annotation.content)
            default: break
            }
        }
        return result
    }
}
