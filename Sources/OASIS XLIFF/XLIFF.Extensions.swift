public import W3C_XML

extension XLIFF {

    public struct Extensions: Sendable, Hashable {

        public var namespaces: [W3C_XML::W3C_XML.Namespace]

        public var attributes: [W3C_XML::W3C_XML.Attribute]

        public var elements: [W3C_XML::W3C_XML.Element]

        public init(
            namespaces: [W3C_XML::W3C_XML.Namespace] = [],
            attributes: [W3C_XML::W3C_XML.Attribute] = [],
            elements: [W3C_XML::W3C_XML.Element] = []
        ) {
            self.namespaces = namespaces
            self.attributes = attributes
            self.elements = elements
        }
    }
}
