extension XLIFF.Annotation {

    public struct End: Sendable, Hashable {

        public var startReference: XLIFF.Identifier

        public init(startReference: XLIFF.Identifier) {
            self.startReference = startReference
        }
    }
}
