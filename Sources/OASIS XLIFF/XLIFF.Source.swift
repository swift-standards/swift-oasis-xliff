public import BCP_47
public import W3C_XML

extension XLIFF {

    public struct Source: Sendable, Hashable {

        public var language: BCP47.LanguageTag?

        public var space: XLIFF.Space?

        public var namespaces: [W3C_XML::W3C_XML.Namespace]

        public var content: [XLIFF.Inline]

        public init(
            language: BCP47.LanguageTag? = nil,
            space: XLIFF.Space? = nil,
            namespaces: [W3C_XML::W3C_XML.Namespace] = [],
            content: [XLIFF.Inline] = []
        ) {
            self.language = language
            self.space = space
            self.namespaces = namespaces
            self.content = content
        }

        public init(_ text: String) {
            self.init(content: XLIFF.Inline.content(text))
        }
    }
}

extension XLIFF.Source {

    public var text: String { content.plainText }
}
