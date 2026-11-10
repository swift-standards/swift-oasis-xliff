public import W3C_XML

extension XLIFF {

    public struct Data: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var direction: XLIFF.Direction?

        public var space: XLIFF.Space?

        public var namespaces: [W3C_XML::W3C_XML.Namespace]

        public var content: [XLIFF.Inline]

        public init(
            id: XLIFF.Identifier,
            direction: XLIFF.Direction? = nil,
            space: XLIFF.Space? = nil,
            namespaces: [W3C_XML::W3C_XML.Namespace] = [],
            content: [XLIFF.Inline] = []
        ) {
            self.id = id
            self.direction = direction
            self.space = space
            self.namespaces = namespaces
            self.content = content
        }
    }
}
