extension XLIFF {

    public struct Identifier: Sendable, Hashable {

        public let value: String

        public init(_ value: String) {
            self.value = value
        }
    }
}

extension XLIFF.Identifier: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension XLIFF.Identifier: CustomStringConvertible {

    public var description: String { value }
}

extension XLIFF.Identifier {

    var isToken: Bool {
        !value.isEmpty && XLIFF.scalars(value).allSatisfy(W3C_XML::W3C_XML.isNameChar)
    }
}
