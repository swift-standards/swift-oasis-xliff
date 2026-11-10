extension XLIFF.Code {

    public enum Kind: String, Sendable, Hashable, CaseIterable {

        case fmt

        case ui

        case quote

        case link

        case image

        case other
    }
}

extension XLIFF.Code.Kind: CustomStringConvertible {

    public var description: String { rawValue }
}
