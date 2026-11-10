extension XLIFF {

    public enum Direction: String, Sendable, Hashable, CaseIterable {

        case ltr

        case rtl

        case auto
    }
}

extension XLIFF.Direction: CustomStringConvertible {

    public var description: String { rawValue }
}
