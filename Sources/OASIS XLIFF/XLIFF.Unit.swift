public import BCP_47

extension XLIFF {

    public struct Unit: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var name: String?

        public var canResegment: Bool?

        public var translate: Bool?

        public var sourceDirection: XLIFF.Direction?

        public var targetDirection: XLIFF.Direction?

        public var space: XLIFF.Space?

        public var language: BCP47.LanguageTag?

        public var type: String?

        public var extensions: XLIFF.Extensions

        public var notes: [XLIFF.Note]

        public var originalData: [XLIFF.Data]

        public var parts: [Part]

        public init(
            id: XLIFF.Identifier,
            name: String? = nil,
            canResegment: Bool? = nil,
            translate: Bool? = nil,
            sourceDirection: XLIFF.Direction? = nil,
            targetDirection: XLIFF.Direction? = nil,
            space: XLIFF.Space? = nil,
            language: BCP47.LanguageTag? = nil,
            type: String? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions(),
            notes: [XLIFF.Note] = [],
            originalData: [XLIFF.Data] = [],
            parts: [Part]
        ) {
            self.id = id
            self.name = name
            self.canResegment = canResegment
            self.translate = translate
            self.sourceDirection = sourceDirection
            self.targetDirection = targetDirection
            self.space = space
            self.language = language
            self.type = type
            self.extensions = extensions
            self.notes = notes
            self.originalData = originalData
            self.parts = parts
        }

        public init(id: XLIFF.Identifier, source: String, target: String? = nil, notes: [XLIFF.Note] = []) {
            self.init(
                id: id,
                notes: notes,
                parts: [.segment(XLIFF.Segment(source: XLIFF.Source(source), target: target.map { XLIFF.Target($0) }))]
            )
        }
    }
}

extension XLIFF.Unit {

    public var sourceText: String {
        parts.map(\.source.text).joined()
    }

    public var targetText: String? {
        let positions = targetPositions
        var composed: [String?] = Array(repeating: nil, count: parts.count)
        for (index, part) in parts.enumerated() {
            let position = positions[index]
            guard composed.indices.contains(position) else { return nil }
            switch part {
            case .segment(let segment):
                guard let target = segment.target else { return nil }
                composed[position] = target.text

            case .ignorable(let ignorable):
                composed[position] = ignorable.target?.text ?? ignorable.source.text
            }
        }
        var result = ""
        for text in composed {
            guard let text else { return nil }
            result += text
        }
        return result
    }

    var targetPositions: [Int] {
        parts.enumerated().map { index, part in
            part.target?.order.map { Int(exactly: $0).map { $0 - 1 } ?? -1 } ?? index
        }
    }
}
