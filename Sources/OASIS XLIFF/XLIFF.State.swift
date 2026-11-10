extension XLIFF {

    public enum State: String, Sendable, Hashable, CaseIterable {

        case initial

        case translated

        case reviewed

        case final
    }
}

extension XLIFF.State: CustomStringConvertible {

    public var description: String { rawValue }
}
