public import BCP_47

extension XLIFF {

    public struct Group: Sendable, Hashable {

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

        public var nodes: [XLIFF.Node]

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
            nodes: [XLIFF.Node] = []
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
            self.nodes = nodes
        }
    }
}
