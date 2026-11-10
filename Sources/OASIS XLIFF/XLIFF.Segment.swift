public import W3C_XML

extension XLIFF {

    public struct Segment: Sendable, Hashable {

        public var id: XLIFF.Identifier?

        public var canResegment: Bool?

        public var state: XLIFF.State?

        public var subState: String?

        public var namespaces: [W3C_XML::W3C_XML.Namespace]

        public var source: XLIFF.Source

        public var target: XLIFF.Target?

        public init(
            id: XLIFF.Identifier? = nil,
            canResegment: Bool? = nil,
            state: XLIFF.State? = nil,
            subState: String? = nil,
            namespaces: [W3C_XML::W3C_XML.Namespace] = [],
            source: XLIFF.Source,
            target: XLIFF.Target? = nil
        ) {
            self.id = id
            self.canResegment = canResegment
            self.state = state
            self.subState = subState
            self.namespaces = namespaces
            self.source = source
            self.target = target
        }
    }
}
