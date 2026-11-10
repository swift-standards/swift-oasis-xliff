import BCP_47
import RFC_3987
import W3C_XML

extension XLIFF.Reader {

    struct Attributes {

        let element: String

        var core: [String: String]

        var xml: [String: String]

        var foreign: [W3C_XML::W3C_XML.Attribute]

        init(_ element: W3C_XML::W3C_XML.Element, scope: XLIFF.Scope) throws(XLIFF.Error) {
            self.element = element.name.local
            self.core = [:]
            self.xml = [:]
            self.foreign = []
            for attribute in element.attributes {
                switch try scope.attribute(attribute.name) {
                case nil:
                    core[attribute.name.local] = attribute.value

                case XLIFF.Namespace.xml:
                    xml[attribute.name.local] = attribute.value

                case XLIFF.Namespace.core:
                    throw .unexpectedAttribute(attribute.name.qualified, on: self.element)

                default:
                    foreign.append(attribute)
                }
            }
        }
    }
}

extension XLIFF.Reader.Attributes {

    mutating func string(_ name: String) -> String? {
        core.removeValue(forKey: name)
    }

    mutating func required(_ name: String) throws(XLIFF.Error) -> String {
        guard let value = string(name) else {
            throw .missingAttribute(name, on: element)
        }
        return value
    }

    mutating func identifier(_ name: String) -> XLIFF.Identifier? {
        string(name).map { XLIFF.Identifier($0) }
    }

    mutating func identifiers(_ name: String) -> [XLIFF.Identifier]? {
        string(name).map { value in
            value.split(whereSeparator: { $0 == " " || $0 == "\t" || $0 == "\n" || $0 == "\r" })
                .map { XLIFF.Identifier(String($0)) }
        }
    }

    mutating func boolean(_ name: String) throws(XLIFF.Error) -> Bool? {
        guard let value = string(name) else { return nil }
        switch value {
        case "yes": return true
        case "no": return false
        default: throw .invalidValue(value, attribute: name, on: element)
        }
    }

    mutating func value<Value: RawRepresentable>(
        _ name: String,
        as type: Value.Type
    ) throws(XLIFF.Error) -> Value? where Value.RawValue == String {
        guard let value = string(name) else { return nil }
        guard let result = Value(rawValue: value) else {
            throw .invalidValue(value, attribute: name, on: element)
        }
        return result
    }

    mutating func reference(_ name: String) throws(XLIFF.Error) -> RFC_3987.IRI.Reference? {
        guard let value = string(name) else { return nil }
        do {
            return try RFC_3987.IRI.Reference(value)
        } catch {
            throw .invalidValue(value, attribute: name, on: element)
        }
    }

    mutating func integer(_ name: String) throws(XLIFF.Error) -> UInt? {
        guard let value = string(name) else { return nil }
        guard !value.isEmpty, value.utf8.allSatisfy({ (0x30...0x39).contains($0) }), let result = UInt(value)
        else {
            throw .invalidValue(value, attribute: name, on: element)
        }
        return result
    }

    mutating func language(_ value: String?, attribute name: String) throws(XLIFF.Error) -> BCP47.LanguageTag? {
        guard let value else { return nil }
        do {
            return try BCP47.LanguageTag(value)
        } catch {
            throw .invalidValue(value, attribute: name, on: element)
        }
    }

    mutating func space() throws(XLIFF.Error) -> XLIFF.Space? {
        guard let value = xml.removeValue(forKey: "space") else { return nil }
        guard let space = XLIFF.Space(rawValue: value) else {
            throw .invalidValue(value, attribute: "xml:space", on: element)
        }
        return space
    }

    mutating func xmlLanguage() throws(XLIFF.Error) -> BCP47.LanguageTag? {
        try language(xml.removeValue(forKey: "lang"), attribute: "xml:lang")
    }

    func finish() throws(XLIFF.Error) {
        if let name = core.keys.sorted().first {
            throw .unexpectedAttribute(name, on: element)
        }
        if let name = xml.keys.sorted().first {
            throw .unexpectedAttribute("xml:" + name, on: element)
        }
        if let attribute = foreign.first {
            throw .unexpectedAttribute(attribute.name.qualified, on: element)
        }
    }

    func extensions(_ namespaces: [W3C_XML::W3C_XML.Namespace]) throws(XLIFF.Error) -> XLIFF.Extensions {
        if let name = core.keys.sorted().first {
            throw .unexpectedAttribute(name, on: element)
        }
        var attributes: [W3C_XML::W3C_XML.Attribute] = xml.keys.sorted().map { key in
            W3C_XML::W3C_XML.Attribute(name: W3C_XML::W3C_XML.Name(local: key, prefix: "xml"), value: xml[key] ?? "")
        }
        attributes += foreign
        return XLIFF.Extensions(namespaces: namespaces, attributes: attributes)
    }
}
