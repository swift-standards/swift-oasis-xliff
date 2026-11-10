import W3C_XML

extension XLIFF.Writer {

    struct Attributes {

        var list: [W3C_XML::W3C_XML.Attribute] = []
    }
}

extension XLIFF.Writer.Attributes {

    mutating func add(_ name: String, _ value: String?) {
        if let value {
            list.append(W3C_XML::W3C_XML.Attribute(name: W3C_XML::W3C_XML.Name(local: name), value: value))
        }
    }

    mutating func add(xml name: String, _ value: String?) {
        if let value {
            list.append(W3C_XML::W3C_XML.Attribute(name: W3C_XML::W3C_XML.Name(local: name, prefix: "xml"), value: value))
        }
    }

    mutating func add(_ name: String, _ value: XLIFF.Identifier?) {
        add(name, value?.value)
    }

    mutating func add(_ name: String, _ value: Bool?) {
        add(name, value.map { $0 ? "yes" : "no" })
    }

    mutating func add(_ name: String, _ value: [XLIFF.Identifier]?) {
        add(name, value.map { $0.map(\.value).joined(separator: " ") })
    }

    mutating func add<Value: CustomStringConvertible>(_ name: String, _ value: Value?) {
        add(name, value?.description)
    }

    mutating func add<Value: CustomStringConvertible>(xml name: String, _ value: Value?) {
        add(xml: name, value?.description)
    }
}
