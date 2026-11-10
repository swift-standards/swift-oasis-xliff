extension XLIFF {

    public enum Space: String, Sendable, Hashable, CaseIterable {

        case `default`

        case preserve
    }
}

extension XLIFF.Space: CustomStringConvertible {

    public var description: String { rawValue }
}
