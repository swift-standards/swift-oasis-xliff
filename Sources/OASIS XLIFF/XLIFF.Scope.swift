import W3C_XML

extension XLIFF {

    struct Scope: Sendable {

        var bindings: [String: String]

        var defaultNamespace: String?

        init(bindings: [String: String] = ["xml": XLIFF.Namespace.xml], defaultNamespace: String? = nil) {
            self.bindings = bindings
            self.defaultNamespace = defaultNamespace
        }
    }
}

extension XLIFF.Scope {

    func adding(_ namespaces: [W3C_XML::W3C_XML.Namespace]) -> Self {
        var copy = self
        for namespace in namespaces {
            if let prefix = namespace.prefix {
                copy.bindings[prefix] = namespace.uri
            } else {
                copy.defaultNamespace = namespace.uri.isEmpty ? nil : namespace.uri
            }
        }
        return copy
    }

    func element(_ name: W3C_XML::W3C_XML.Name) throws(XLIFF.Error) -> String? {
        guard let prefix = name.prefix else { return defaultNamespace }
        guard let uri = bindings[prefix] else { throw .undeclaredPrefix(prefix) }
        return uri
    }

    func attribute(_ name: W3C_XML::W3C_XML.Name) throws(XLIFF.Error) -> String? {
        guard let prefix = name.prefix else { return nil }
        guard let uri = bindings[prefix] else { throw .undeclaredPrefix(prefix) }
        return uri
    }

    func isCore(_ element: W3C_XML::W3C_XML.Element) throws(XLIFF.Error) -> Bool {
        try self.element(element.name) == XLIFF.Namespace.core
    }

    func selfContained(_ element: W3C_XML::W3C_XML.Element) -> W3C_XML::W3C_XML.Element {
        var used: Set<String> = []
        var usesDefault = false
        collect(element, into: &used, usesDefault: &usesDefault)
        var copy = element
        let declared = Set(element.namespaces.map { $0.prefix ?? "" })
        for prefix in used.sorted() where prefix != "xml" && !declared.contains(prefix) {
            if let uri = bindings[prefix] {
                copy.namespaces.append(W3C_XML::W3C_XML.Namespace(prefix: prefix, uri: uri))
            }
        }
        if usesDefault, !declared.contains(""), let defaultNamespace {
            copy.namespaces.insert(W3C_XML::W3C_XML.Namespace(uri: defaultNamespace), at: 0)
        }
        return copy
    }

    private func collect(_ element: W3C_XML::W3C_XML.Element, into used: inout Set<String>, usesDefault: inout Bool) {
        if let prefix = element.name.prefix {
            used.insert(prefix)
        } else {
            usesDefault = true
        }
        for attribute in element.attributes {
            if let prefix = attribute.name.prefix {
                used.insert(prefix)
            }
        }
        for child in element.children {
            collect(child, into: &used, usesDefault: &usesDefault)
        }
    }
}
