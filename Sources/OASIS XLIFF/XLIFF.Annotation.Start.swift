extension XLIFF.Annotation {

    public struct Start: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var translate: Bool?

        public var type: Kind?

        public var reference: String?

        public var value: String?

        public var extensions: XLIFF.Extensions

        public init(
            id: XLIFF.Identifier,
            translate: Bool? = nil,
            type: Kind? = nil,
            reference: String? = nil,
            value: String? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions()
        ) {
            self.id = id
            self.translate = translate
            self.type = type
            self.reference = reference
            self.value = value
            self.extensions = extensions
        }
    }
}
