extension XLIFF {

    public struct CodePoint: Sendable, Hashable {

        public let value: UInt32

        public init(_ value: UInt32) {
            self.value = value
        }
    }
}

extension XLIFF.CodePoint {

    public var scalar: Unicode.Scalar? {
        Unicode.Scalar(value)
    }

    var isEncodable: Bool {
        guard value <= 0x10FFFF else { return false }
        if (0x7F...0x84).contains(value) || (0x86...0x9F).contains(value) { return true }
        guard let scalar else { return true }
        return !W3C_XML::W3C_XML.isChar(scalar)
    }

    var hex: String {
        var digits = String(value, radix: 16, uppercase: true)
        while digits.count < 4 || digits.count % 2 == 1 {
            digits = "0" + digits
        }
        return digits
    }

    init?(hex: String) {
        guard !hex.isEmpty, hex.count % 2 == 0, hex.count <= 8,
            hex.utf8.allSatisfy({ (0x30...0x39).contains($0) || (0x41...0x46).contains($0) || (0x61...0x66).contains($0) }),
            let value = UInt32(hex, radix: 16)
        else { return nil }
        self.init(value)
    }
}
