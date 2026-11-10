public import RFC_3987
public import W3C_XML

extension XLIFF {

    public struct Skeleton: Sendable, Hashable {

        public var href: RFC_3987.IRI.Reference?

        public var namespaces: [W3C_XML::W3C_XML.Namespace]

        public var content: [W3C_XML::W3C_XML.Content]

        public init(
            href: RFC_3987.IRI.Reference? = nil,
            namespaces: [W3C_XML::W3C_XML.Namespace] = [],
            content: [W3C_XML::W3C_XML.Content] = []
        ) {
            self.href = href
            self.namespaces = namespaces
            self.content = content
        }
    }
}
