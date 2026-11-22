import W3C_XML

extension XLIFF.Document {

    public var bytes: [UInt8] {
        XLIFF.Writer().document(self).encode(options: W3C.XML.Options(includeDeclaration: true))
    }
}
