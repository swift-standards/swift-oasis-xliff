import BCP_47
import RFC_3987
import W3C_XML

extension XLIFF {

    struct Writer {}
}

extension XLIFF.Writer {

    func document(_ document: XLIFF.Document) -> W3C_XML::W3C_XML.Document {
        var attributes = Attributes()
        attributes.add("version", document.version)
        attributes.add("srcLang", document.sourceLanguage.value)
        attributes.add("trgLang", document.targetLanguage?.value)
        attributes.add(xml: "lang", document.language?.value)
        attributes.add(xml: "space", document.space)
        attributes.list += document.extensions.attributes
        let root = structure(
            "xliff",
            attributes: attributes,
            namespaces: [W3C_XML::W3C_XML.Namespace(uri: XLIFF.Namespace.core)] + Self.prefixed(document.extensions.namespaces),
            children: document.files.map { file($0, depth: 1) },
            depth: 0
        )
        return W3C_XML::W3C_XML.Document(
            declaration: W3C_XML::W3C_XML.Declaration(version: .v1_0, encoding: "UTF-8"),
            root: root,
            prologue: document.prologue,
            epilogue: document.epilogue
        )
    }
}

extension XLIFF.Writer {

    static func prefixed(_ namespaces: [W3C_XML::W3C_XML.Namespace]) -> [W3C_XML::W3C_XML.Namespace] {
        namespaces.filter { $0.prefix != nil }
    }

    func structure(
        _ name: String,
        attributes: Attributes,
        namespaces: [W3C_XML::W3C_XML.Namespace],
        children: [W3C_XML::W3C_XML.Element],
        depth: Int
    ) -> W3C_XML::W3C_XML.Element {
        var content: [W3C_XML::W3C_XML.Content] = []
        for child in children {
            content.append(.text("\n" + String(repeating: "  ", count: depth + 1)))
            content.append(.element(child))
        }
        if !children.isEmpty {
            content.append(.text("\n" + String(repeating: "  ", count: depth)))
        }
        return W3C_XML::W3C_XML.Element(
            name: W3C_XML::W3C_XML.Name(local: name),
            attributes: attributes.list,
            content: content,
            namespaces: namespaces
        )
    }

    func file(_ file: XLIFF.File, depth: Int) -> W3C_XML::W3C_XML.Element {
        var attributes = Attributes()
        attributes.add("id", file.id)
        attributes.add("canResegment", file.canResegment)
        attributes.add("original", file.original?.value)
        attributes.add("translate", file.translate)
        attributes.add("srcDir", file.sourceDirection)
        attributes.add("trgDir", file.targetDirection)
        attributes.add(xml: "lang", file.language?.value)
        attributes.add(xml: "space", file.space)
        attributes.list += file.extensions.attributes
        var children: [W3C_XML::W3C_XML.Element] = []
        if let skeleton = file.skeleton {
            var skeletonAttributes = Attributes()
            skeletonAttributes.add("href", skeleton.href?.value)
            children.append(
                W3C_XML::W3C_XML.Element(
                    name: W3C_XML::W3C_XML.Name(local: "skeleton"),
                    attributes: skeletonAttributes.list,
                    content: skeleton.content,
                    namespaces: Self.prefixed(skeleton.namespaces)
                )
            )
        }
        children += file.extensions.elements
        if !file.notes.isEmpty {
            children.append(notes(file.notes, depth: depth + 1))
        }
        children += file.nodes.map { node($0, depth: depth + 1) }
        return structure(
            "file",
            attributes: attributes,
            namespaces: Self.prefixed(file.extensions.namespaces),
            children: children,
            depth: depth
        )
    }

    func node(_ node: XLIFF.Node, depth: Int) -> W3C_XML::W3C_XML.Element {
        switch node {
        case .unit(let unit): self.unit(unit, depth: depth)
        case .group(let group): self.group(group, depth: depth)
        }
    }

    func group(_ group: XLIFF.Group, depth: Int) -> W3C_XML::W3C_XML.Element {
        var attributes = Attributes()
        attributes.add("id", group.id)
        attributes.add("name", group.name)
        attributes.add("canResegment", group.canResegment)
        attributes.add("translate", group.translate)
        attributes.add("srcDir", group.sourceDirection)
        attributes.add("trgDir", group.targetDirection)
        attributes.add("type", group.type)
        attributes.add(xml: "lang", group.language?.value)
        attributes.add(xml: "space", group.space)
        attributes.list += group.extensions.attributes
        var children = group.extensions.elements
        if !group.notes.isEmpty {
            children.append(notes(group.notes, depth: depth + 1))
        }
        children += group.nodes.map { node($0, depth: depth + 1) }
        return structure(
            "group",
            attributes: attributes,
            namespaces: Self.prefixed(group.extensions.namespaces),
            children: children,
            depth: depth
        )
    }

    func unit(_ unit: XLIFF.Unit, depth: Int) -> W3C_XML::W3C_XML.Element {
        var attributes = Attributes()
        attributes.add("id", unit.id)
        attributes.add("name", unit.name)
        attributes.add("canResegment", unit.canResegment)
        attributes.add("translate", unit.translate)
        attributes.add("srcDir", unit.sourceDirection)
        attributes.add("trgDir", unit.targetDirection)
        attributes.add("type", unit.type)
        attributes.add(xml: "lang", unit.language?.value)
        attributes.add(xml: "space", unit.space)
        attributes.list += unit.extensions.attributes
        var children = unit.extensions.elements
        if !unit.notes.isEmpty {
            children.append(notes(unit.notes, depth: depth + 1))
        }
        if !unit.originalData.isEmpty {
            children.append(
                structure(
                    "originalData",
                    attributes: Attributes(),
                    namespaces: [],
                    children: unit.originalData.map(data),
                    depth: depth + 1
                )
            )
        }
        for part in unit.parts {
            switch part {
            case .segment(let segment):
                var segmentAttributes = Attributes()
                segmentAttributes.add("id", segment.id)
                segmentAttributes.add("canResegment", segment.canResegment)
                segmentAttributes.add("state", segment.state)
                segmentAttributes.add("subState", segment.subState)
                children.append(
                    pair(
                        "segment",
                        attributes: segmentAttributes,
                        namespaces: segment.namespaces,
                        source: segment.source,
                        target: segment.target,
                        depth: depth + 1
                    )
                )

            case .ignorable(let ignorable):
                var ignorableAttributes = Attributes()
                ignorableAttributes.add("id", ignorable.id)
                children.append(
                    pair(
                        "ignorable",
                        attributes: ignorableAttributes,
                        namespaces: ignorable.namespaces,
                        source: ignorable.source,
                        target: ignorable.target,
                        depth: depth + 1
                    )
                )
            }
        }
        return structure(
            "unit",
            attributes: attributes,
            namespaces: Self.prefixed(unit.extensions.namespaces),
            children: children,
            depth: depth
        )
    }

    func notes(_ notes: [XLIFF.Note], depth: Int) -> W3C_XML::W3C_XML.Element {
        structure(
            "notes",
            attributes: Attributes(),
            namespaces: [],
            children: notes.map { note in
                var attributes = Attributes()
                attributes.add("id", note.id)
                attributes.add("appliesTo", note.subject)
                attributes.add("category", note.category)
                attributes.add("priority", note.priority)
                attributes.list += note.extensions.attributes
                return W3C_XML::W3C_XML.Element(
                    name: W3C_XML::W3C_XML.Name(local: "note"),
                    attributes: attributes.list,
                    content: note.text.isEmpty ? [] : [.text(note.text)],
                    namespaces: Self.prefixed(note.extensions.namespaces)
                )
            },
            depth: depth
        )
    }

    func data(_ data: XLIFF.Data) -> W3C_XML::W3C_XML.Element {
        var attributes = Attributes()
        attributes.add("id", data.id)
        attributes.add("dir", data.direction)
        attributes.add(xml: "space", data.space)
        return W3C_XML::W3C_XML.Element(
            name: W3C_XML::W3C_XML.Name(local: "data"),
            attributes: attributes.list,
            content: inline(data.content),
            namespaces: Self.prefixed(data.namespaces)
        )
    }

    func pair(
        _ name: String,
        attributes: Attributes,
        namespaces: [W3C_XML::W3C_XML.Namespace],
        source: XLIFF.Source,
        target: XLIFF.Target?,
        depth: Int
    ) -> W3C_XML::W3C_XML.Element {
        var sourceAttributes = Attributes()
        sourceAttributes.add(xml: "lang", source.language?.value)
        sourceAttributes.add(xml: "space", source.space)
        var children = [
            W3C_XML::W3C_XML.Element(
                name: W3C_XML::W3C_XML.Name(local: "source"),
                attributes: sourceAttributes.list,
                content: inline(source.content),
                namespaces: Self.prefixed(source.namespaces)
            )
        ]
        if let target {
            var targetAttributes = Attributes()
            targetAttributes.add(xml: "lang", target.language?.value)
            targetAttributes.add(xml: "space", target.space)
            targetAttributes.add("order", target.order)
            children.append(
                W3C_XML::W3C_XML.Element(
                    name: W3C_XML::W3C_XML.Name(local: "target"),
                    attributes: targetAttributes.list,
                    content: inline(target.content),
                    namespaces: Self.prefixed(target.namespaces)
                )
            )
        }
        return structure(
            name,
            attributes: attributes,
            namespaces: Self.prefixed(namespaces),
            children: children,
            depth: depth
        )
    }
}
