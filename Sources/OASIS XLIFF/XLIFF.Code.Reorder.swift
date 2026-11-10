extension XLIFF.Code {

    public enum Reorder: String, Sendable, Hashable, CaseIterable {

        case yes

        case firstNo

        case no
    }
}

extension XLIFF.Code.Reorder: CustomStringConvertible {

    public var description: String { rawValue }
}
