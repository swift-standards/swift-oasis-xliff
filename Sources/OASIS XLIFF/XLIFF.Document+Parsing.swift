import W3C_XML

extension XLIFF.Document {

    public init<Bytes: Swift::Collection<UInt8> & Sendable>(
        parsing bytes: Bytes,
        prefixes: [String: String] = [:]
    ) throws(XLIFF.Error) {
        let xml: W3C_XML::W3C_XML.Document
        do throws(W3C_XML::W3C_XML.Parse.Error) {
            xml = try W3C_XML::W3C_XML.parse(bytes)
        } catch {
            throw .xml(error)
        }
        self = try XLIFF.Reader().document(xml)
        try validate(prefixes: prefixes)
    }
}
