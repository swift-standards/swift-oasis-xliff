public import W3C_XML

extension XLIFF {

    public struct Ignorable: Sendable, Hashable {

        public var id: XLIFF.Identifier?

        public var namespaces: [W3C_XML::W3C_XML.Namespace]

        public var source: XLIFF.Source

        public var target: XLIFF.Target?

        public init(
            id: XLIFF.Identifier? = nil,
            namespaces: [W3C_XML::W3C_XML.Namespace] = [],
            source: XLIFF.Source,
            target: XLIFF.Target? = nil
        ) {
            self.id = id
            self.namespaces = namespaces
            self.source = source
            self.target = target
        }
    }
}
