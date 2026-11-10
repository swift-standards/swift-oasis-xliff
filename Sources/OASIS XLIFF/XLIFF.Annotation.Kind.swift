extension XLIFF.Annotation {

    public enum Kind: Sendable, Hashable {

        case generic

        case comment

        case term

        case custom(String)
    }
}

extension XLIFF.Annotation.Kind: RawRepresentable {

    public init(rawValue: String) {
        switch rawValue {
        case "generic": self = .generic
        case "comment": self = .comment
        case "term": self = .term
        default: self = .custom(rawValue)
        }
    }

    public var rawValue: String {
        switch self {
        case .generic: "generic"
        case .comment: "comment"
        case .term: "term"
        case .custom(let value): value
        }
    }
}

extension XLIFF.Annotation.Kind: CustomStringConvertible {

    public var description: String { rawValue }
}
