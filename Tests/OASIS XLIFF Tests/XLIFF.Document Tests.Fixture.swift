import Testing

extension `XLIFF.Document Tests` {

    struct Fixture: Sendable, CustomTestStringConvertible {

        let name: String

        let bytes: [UInt8]

        init(_ name: String, byteOrderMark: Bool, _ text: String) {
            self.name = name
            self.bytes = (byteOrderMark ? [0xEF, 0xBB, 0xBF] : []) + Array(text.utf8)
        }

        var testDescription: String { name }
    }
}

extension [`XLIFF.Document Tests`.Fixture] {

    subscript(name: String) -> `XLIFF.Document Tests`.Fixture? {
        first { $0.name.hasSuffix("/" + name) }
    }
}
