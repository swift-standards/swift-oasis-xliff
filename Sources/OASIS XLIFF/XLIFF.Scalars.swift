extension XLIFF {

    static func scalars(_ text: String) -> [Unicode.Scalar] {
        var result: [Unicode.Scalar] = []
        var iterator = text.utf8.makeIterator()
        var decoder = Unicode.UTF8()
        while case .scalarValue(let scalar) = decoder.decode(&iterator) {
            result.append(scalar)
        }
        return result
    }
}
