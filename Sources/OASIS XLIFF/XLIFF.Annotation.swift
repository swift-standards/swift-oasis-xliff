extension XLIFF {

    public struct Annotation: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var translate: Bool?

        public var type: Kind?

        public var reference: String?

        public var value: String?

        public var extensions: XLIFF.Extensions

        public var content: [XLIFF.Inline]

        public init(
            id: XLIFF.Identifier,
            translate: Bool? = nil,
            type: Kind? = nil,
            reference: String? = nil,
            value: String? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions(),
            content: [XLIFF.Inline] = []
        ) {
            self.id = id
            self.translate = translate
            self.type = type
            self.reference = reference
            self.value = value
            self.extensions = extensions
            self.content = content
        }
    }
}
