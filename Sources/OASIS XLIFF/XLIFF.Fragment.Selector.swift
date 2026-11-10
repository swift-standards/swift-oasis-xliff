extension XLIFF.Fragment {

    public struct Selector: Sendable, Hashable {

        public let prefix: String?

        public let id: XLIFF.Identifier

        public init(prefix: String?, id: XLIFF.Identifier) {
            self.prefix = prefix
            self.id = id
        }
    }
}
