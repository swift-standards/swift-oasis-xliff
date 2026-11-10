import W3C_XML

extension XLIFF.Document {

    public var bytes: [UInt8] {
        XLIFF.Writer().document(self).encode(options: W3C_XML::W3C_XML.Options(includeDeclaration: true))
    }
}
