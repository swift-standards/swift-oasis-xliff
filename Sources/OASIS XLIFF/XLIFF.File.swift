public import BCP_47
public import RFC_3987

extension XLIFF {

    public struct File: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var original: RFC_3987.IRI.Reference?

        public var canResegment: Bool?

        public var translate: Bool?

        public var sourceDirection: XLIFF.Direction?

        public var targetDirection: XLIFF.Direction?

        public var space: XLIFF.Space?

        public var language: BCP47.LanguageTag?

        public var skeleton: XLIFF.Skeleton?

        public var extensions: XLIFF.Extensions

        public var notes: [XLIFF.Note]

        public var nodes: [XLIFF.Node]

        public init(
            id: XLIFF.Identifier,
            original: RFC_3987.IRI.Reference? = nil,
            canResegment: Bool? = nil,
            translate: Bool? = nil,
            sourceDirection: XLIFF.Direction? = nil,
            targetDirection: XLIFF.Direction? = nil,
            space: XLIFF.Space? = nil,
            language: BCP47.LanguageTag? = nil,
            skeleton: XLIFF.Skeleton? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions(),
            notes: [XLIFF.Note] = [],
            nodes: [XLIFF.Node]
        ) {
            self.id = id
            self.original = original
            self.canResegment = canResegment
            self.translate = translate
            self.sourceDirection = sourceDirection
            self.targetDirection = targetDirection
            self.space = space
            self.language = language
            self.skeleton = skeleton
            self.extensions = extensions
            self.notes = notes
            self.nodes = nodes
        }
    }
}

extension XLIFF.File {

    public var units: [XLIFF.Unit] { nodes.units }
}
