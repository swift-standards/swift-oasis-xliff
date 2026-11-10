extension XLIFF {

    public struct Note: Sendable, Hashable {

        public var id: XLIFF.Identifier?

        public var subject: Subject?

        public var category: String?

        public var priority: UInt?

        public var extensions: XLIFF.Extensions

        public var text: String

        public init(
            _ text: String,
            id: XLIFF.Identifier? = nil,
            subject: Subject? = nil,
            category: String? = nil,
            priority: UInt? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions()
        ) {
            self.text = text
            self.id = id
            self.subject = subject
            self.category = category
            self.priority = priority
            self.extensions = extensions
        }
    }
}
