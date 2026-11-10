extension XLIFF.Note {

    public enum Subject: String, Sendable, Hashable, CaseIterable {

        case source

        case target
    }
}

extension XLIFF.Note.Subject: CustomStringConvertible {

    public var description: String { rawValue }
}
