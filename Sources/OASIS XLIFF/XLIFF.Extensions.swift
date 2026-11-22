public import W3C_XML

extension XLIFF {

    public struct Extensions: Sendable, Hashable {

        public var namespaces: [W3C.XML.Namespace]

        public var attributes: [W3C.XML.Attribute]

        public var elements: [W3C.XML.Element]

        public init(
            namespaces: [W3C.XML.Namespace] = [],
            attributes: [W3C.XML.Attribute] = [],
            elements: [W3C.XML.Element] = []
        ) {
            self.namespaces = namespaces
            self.attributes = attributes
            self.elements = elements
        }
    }
}
