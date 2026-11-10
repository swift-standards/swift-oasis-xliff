extension XLIFF {

    public enum Version: String, Sendable, Hashable, CaseIterable {

        case v2_0 = "2.0"

        case v2_1 = "2.1"
    }
}

extension XLIFF.Version: CustomStringConvertible {

    public var description: String { rawValue }
}
