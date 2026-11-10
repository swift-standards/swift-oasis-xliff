import W3C_XML

extension XLIFF.Writer {

    func inline(_ content: [XLIFF.Inline]) -> [W3C_XML::W3C_XML.Content] {
        var result: [W3C_XML::W3C_XML.Content] = []
        for item in content {
            switch item {
            case .text(let text):
                for piece in XLIFF.Inline.content(text) {
                    if case .codePoint(let point) = piece {
                        result.append(.element(codePoint(point)))
                    } else if case .text(let run) = piece {
                        result.append(.text(run))
                    }
                }

            case .codePoint(let point):
                result.append(.element(codePoint(point)))

            case .standalone(let code):
                var attributes = Attributes()
                attributes.add("id", code.id)
                attributes.add("canCopy", code.canCopy)
                attributes.add("canDelete", code.canDelete)
                attributes.add("canReorder", code.canReorder)
                attributes.add("copyOf", code.copyOf)
                attributes.add("disp", code.display)
                attributes.add("equiv", code.equivalent)
                attributes.add("dataRef", code.data)
                attributes.add("subFlows", code.subFlows)
                attributes.add("type", code.type)
                attributes.add("subType", code.subType)
                result.append(.element(element("ph", attributes, code.extensions)))

            case .spanning(let code):
                var attributes = Attributes()
                attributes.add("id", code.id)
                attributes.add("canCopy", code.canCopy)
                attributes.add("canDelete", code.canDelete)
                attributes.add("canOverlap", code.canOverlap)
                attributes.add("canReorder", code.canReorder)
                attributes.add("copyOf", code.copyOf)
                attributes.add("dispStart", code.displayStart)
                attributes.add("dispEnd", code.displayEnd)
                attributes.add("equivStart", code.equivalentStart)
                attributes.add("equivEnd", code.equivalentEnd)
                attributes.add("dataRefStart", code.dataStart)
                attributes.add("dataRefEnd", code.dataEnd)
                attributes.add("subFlowsStart", code.subFlowsStart)
                attributes.add("subFlowsEnd", code.subFlowsEnd)
                attributes.add("type", code.type)
                attributes.add("subType", code.subType)
                attributes.add("dir", code.direction)
                result.append(.element(element("pc", attributes, code.extensions, content: inline(code.content))))

            case .start(let code):
                var attributes = Attributes()
                attributes.add("id", code.id)
                attributes.add("isolated", code.isolated)
                hints(&attributes, code.canCopy, code.canDelete, code.canOverlap, code.canReorder)
                attributes.add("copyOf", code.copyOf)
                attributes.add("disp", code.display)
                attributes.add("equiv", code.equivalent)
                attributes.add("dataRef", code.data)
                attributes.add("subFlows", code.subFlows)
                attributes.add("type", code.type)
                attributes.add("subType", code.subType)
                attributes.add("dir", code.direction)
                result.append(.element(element("sc", attributes, code.extensions)))

            case .end(let code):
                var attributes = Attributes()
                attributes.add("id", code.id)
                attributes.add("startRef", code.startReference)
                attributes.add("isolated", code.isolated)
                hints(&attributes, code.canCopy, code.canDelete, code.canOverlap, code.canReorder)
                attributes.add("copyOf", code.copyOf)
                attributes.add("disp", code.display)
                attributes.add("equiv", code.equivalent)
                attributes.add("dataRef", code.data)
                attributes.add("subFlows", code.subFlows)
                attributes.add("type", code.type)
                attributes.add("subType", code.subType)
                attributes.add("dir", code.direction)
                result.append(.element(element("ec", attributes, code.extensions)))

            case .annotation(let annotation):
                var attributes = Attributes()
                attributes.add("id", annotation.id)
                attributes.add("translate", annotation.translate)
                attributes.add("type", annotation.type)
                attributes.add("ref", annotation.reference)
                attributes.add("value", annotation.value)
                result.append(
                    .element(element("mrk", attributes, annotation.extensions, content: inline(annotation.content)))
                )

            case .annotationStart(let annotation):
                var attributes = Attributes()
                attributes.add("id", annotation.id)
                attributes.add("translate", annotation.translate)
                attributes.add("type", annotation.type)
                attributes.add("ref", annotation.reference)
                attributes.add("value", annotation.value)
                result.append(.element(element("sm", attributes, annotation.extensions)))

            case .annotationEnd(let annotation):
                var attributes = Attributes()
                attributes.add("startRef", annotation.startReference)
                result.append(.element(element("em", attributes, XLIFF.Extensions())))
            }
        }
        return result
    }

    func hints(
        _ attributes: inout Attributes,
        _ canCopy: Bool?,
        _ canDelete: Bool?,
        _ canOverlap: Bool?,
        _ canReorder: XLIFF.Code.Reorder?
    ) {
        attributes.add("canCopy", canCopy)
        attributes.add("canDelete", canDelete)
        attributes.add("canOverlap", canOverlap)
        attributes.add("canReorder", canReorder)
    }

    func codePoint(_ point: XLIFF.CodePoint) -> W3C_XML::W3C_XML.Element {
        var attributes = Attributes()
        attributes.add("hex", point.hex)
        return W3C_XML::W3C_XML.Element(name: W3C_XML::W3C_XML.Name(local: "cp"), attributes: attributes.list)
    }

    func element(
        _ name: String,
        _ attributes: Attributes,
        _ extensions: XLIFF.Extensions,
        content: [W3C_XML::W3C_XML.Content] = []
    ) -> W3C_XML::W3C_XML.Element {
        W3C_XML::W3C_XML.Element(
            name: W3C_XML::W3C_XML.Name(local: name),
            attributes: attributes.list + extensions.attributes,
            content: content,
            namespaces: Self.prefixed(extensions.namespaces)
        )
    }
}
