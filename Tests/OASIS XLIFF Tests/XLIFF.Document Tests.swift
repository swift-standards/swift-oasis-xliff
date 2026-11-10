import OASIS_XLIFF
import Testing

enum `XLIFF.Document Tests` {}

extension `XLIFF.Document Tests` {
    @Suite struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
    }
}

extension `XLIFF.Document Tests` {

    static func parse(_ text: String) throws(XLIFF.Error) -> XLIFF.Document {
        try XLIFF.Document(parsing: Array(text.utf8))
    }

    static func document(_ body: String, target: Bool = true) -> String {
        """
        <?xml version="1.0" encoding="UTF-8"?>
        <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.1" srcLang="en"\
        \(target ? " trgLang=\"nl\"" : "")>
        <file id="f1">\(body)</file>
        </xliff>
        """
    }
}

extension `XLIFF.Document Tests`.Test.Unit {

    @Test
    func `a document built from source and target pairs reads back its targets by unit id`() throws {
        let document = try XLIFF.Document(
            source: BCP47.LanguageTag("en"),
            target: BCP47.LanguageTag("nl"),
            units: [
                XLIFF.Unit(id: "browse", source: "Browse", target: "Bladeren"),
                XLIFF.Unit(id: "apps", source: "Apps"),
            ]
        )
        let read = try XLIFF.Document(parsing: document.bytes)
        #expect(read == document)
        #expect(read.targets == ["browse": "Bladeren"])
        #expect(read.target(of: "browse") == "Bladeren")
        #expect(read.target(of: "apps") == nil)
        #expect(read.units.map(\.sourceText) == ["Browse", "Apps"])
    }

    @Test
    func `the builder writes one file with one segment per unit`() throws {
        let document = try XLIFF.Document(
            source: BCP47.LanguageTag("en"),
            target: BCP47.LanguageTag("nl"),
            units: [XLIFF.Unit(id: "browse", source: "Browse", target: "Bladeren")]
        )
        let text = String(decoding: document.bytes, as: UTF8.self)
        #expect(
            text == """
                <?xml version="1.0" encoding="UTF-8"?><xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" \
                version="2.1" srcLang="en" trgLang="nl">
                  <file id="f1">
                    <unit id="browse">
                      <segment>
                        <source>Browse</source>
                        <target>Bladeren</target>
                      </segment>
                    </unit>
                  </file>
                </xliff>
                """
        )
    }

    @Test
    func `the builder refuses units that break a constraint`() {
        #expect(throws: XLIFF.Error.duplicateIdentifier("a", element: "unit")) {
            try XLIFF.Document(
                source: BCP47.LanguageTag("en"),
                target: BCP47.LanguageTag("nl"),
                units: [XLIFF.Unit(id: "a", source: "One"), XLIFF.Unit(id: "a", source: "Two")]
            )
        }
        #expect(throws: XLIFF.Error.invalidValue("a b", attribute: "id", on: "unit")) {
            try XLIFF.Document(
                source: BCP47.LanguageTag("en"),
                target: BCP47.LanguageTag("nl"),
                units: [XLIFF.Unit(id: "a b", source: "One")]
            )
        }
    }

    @Test
    func `files, groups, units, segments, notes and states are read into typed values`() throws {
        let document = try `XLIFF.Document Tests`.parse(
            `XLIFF.Document Tests`.document(
                """
                <notes><note id="n1" appliesTo="source" priority="2" category="ui">File note</note></notes>
                <group id="g1" name="menu">
                  <unit id="u1" name="browse">
                    <segment id="s1" state="translated" subState="my:checked">
                      <source>Browse</source>
                      <target>Bladeren</target>
                    </segment>
                  </unit>
                </group>
                """
            )
        )
        #expect(document.version == .v2_1)
        #expect(document.sourceLanguage == (try BCP47.LanguageTag("en")))
        #expect(document.targetLanguage == (try BCP47.LanguageTag("nl")))
        let file = try #require(document.files.first)
        #expect(file.notes == [XLIFF.Note("File note", id: "n1", subject: .source, category: "ui", priority: 2)])
        guard case .group(let group) = file.nodes.first, case .unit(let unit) = group.nodes.first,
            case .segment(let segment) = unit.parts.first
        else {
            Issue.record("expected a group holding a unit with a segment")
            return
        }
        #expect(group.name == "menu")
        #expect(unit.name == "browse")
        #expect(segment.state == .translated)
        #expect(segment.subState == "my:checked")
        #expect(segment.source.text == "Browse")
        #expect(segment.target?.text == "Bladeren")
    }

    @Test
    func `inline codes are read into typed values and written back`() throws {
        let text = `XLIFF.Document Tests`.document(
            """
            <unit id="u1">
              <originalData><data id="d1">%s</data><data id="d2">&lt;b></data><data id="d3">&lt;/b></data></originalData>
              <segment>
                <source>Open <ph id="1" dataRef="d1" equiv="file"/> in <pc id="2" dataRefStart="d2" dataRefEnd="d3" \
            type="fmt" subType="xlf:b">bold</pc> <sc id="3" type="fmt"/>now<ec startRef="3" type="fmt"/>\
            <mrk id="m1" type="term" ref="https://example.com">term</mrk><sm id="m2" translate="no"/>x<em startRef="m2"/>\
            <cp hex="0003"/></source>
              </segment>
            </unit>
            """,
            target: false
        )
        let document = try `XLIFF.Document Tests`.parse(text)
        let unit = try #require(document.units.first)
        let content = unit.parts[0].source.content
        #expect(
            content[1]
                == .standalone(XLIFF.Code.Standalone(id: "1", equivalent: "file", data: "d1"))
        )
        #expect(
            content[3]
                == .spanning(
                    XLIFF.Code.Spanning(
                        id: "2",
                        dataStart: "d2",
                        dataEnd: "d3",
                        type: .fmt,
                        subType: "xlf:b",
                        content: [.text("bold")]
                    )
                )
        )
        #expect(content[5] == .start(XLIFF.Code.Start(id: "3", type: .fmt)))
        #expect(content[7] == .end(XLIFF.Code.End(startReference: "3", type: .fmt)))
        #expect(
            content[8]
                == .annotation(
                    XLIFF.Annotation(id: "m1", type: .term, reference: "https://example.com", content: [.text("term")])
                )
        )
        #expect(content[9] == .annotationStart(XLIFF.Annotation.Start(id: "m2", translate: false)))
        #expect(content[11] == .annotationEnd(XLIFF.Annotation.End(startReference: "m2")))
        #expect(content[12] == .codePoint(XLIFF.CodePoint(3)))
        #expect(unit.originalData.map(\.content) == [[.text("%s")], [.text("<b>")], [.text("</b>")]])
        #expect(try XLIFF.Document(parsing: document.bytes) == document)
    }

    @Test
    func `plain text joins text, code points, equivalents and the content of pc and mrk`() throws {
        let source = XLIFF.Source(
            content: [
                .text("Open "),
                .standalone(XLIFF.Code.Standalone(id: "1", equivalent: "file")),
                .standalone(XLIFF.Code.Standalone(id: "2")),
                .spanning(
                    XLIFF.Code.Spanning(id: "3", equivalentStart: "[", equivalentEnd: "]", content: [.text("bold")])
                ),
                .annotation(XLIFF.Annotation(id: "m", content: [.text(" term")])),
                .annotationStart(XLIFF.Annotation.Start(id: "s")),
                .codePoint(XLIFF.CodePoint(0x41)),
                .codePoint(XLIFF.CodePoint(0xD800)),
            ]
        )
        #expect(source.text == "Open file[bold] termA\u{FFFD}")
    }

    @Test
    func `a unit's target follows the order attribute and takes an ignorable's source when it has no target`()
        throws
    {
        let document = try `XLIFF.Document Tests`.parse(
            `XLIFF.Document Tests`.document(
                """
                <unit id="u1">
                  <segment><source>A.</source><target order="3">Phrase A.</target></segment>
                  <ignorable><source> </source></ignorable>
                  <segment><source>B.</source><target order="1">Phrase B.</target></segment>
                </unit>
                """
            )
        )
        #expect(document.target(of: "u1") == "Phrase B. Phrase A.")
        #expect(document.units[0].sourceText == "A. B.")
    }

    @Test
    func `a unit with a segment that has no target has no target`() throws {
        let document = try `XLIFF.Document Tests`.parse(
            `XLIFF.Document Tests`.document(
                """
                <unit id="u1">
                  <segment><source>A.</source><target>Phrase A.</target></segment>
                  <segment><source>B.</source></segment>
                </unit>
                """
            )
        )
        #expect(document.target(of: "u1") == nil)
        #expect(document.targets.isEmpty)
    }
}

extension `XLIFF.Document Tests`.Test.`Edge Case` {

    @Test
    func `the first unit with an identifier wins across files`() throws {
        let text = """
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.1" srcLang="en" trgLang="nl">
            <file id="f1"><unit id="u"><segment><source>A</source></segment></unit></file>
            <file id="f2"><unit id="u"><segment><source>B</source><target>Bee</target></segment></unit></file>
            </xliff>
            """
        let document = try `XLIFF.Document Tests`.parse(text)
        #expect(document.target(of: "u") == nil)
        #expect(document.targets.isEmpty)
    }

    @Test(arguments: ["1.2", "2.2", ""])
    func `versions other than 2.0 and 2.1 are refused`(version: String) {
        let text = """
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="\(version)" srcLang="en">\
            <file id="f"><unit id="u"><segment><source>A</source></segment></unit></file></xliff>
            """
        #expect(throws: XLIFF.Error.invalidValue(version, attribute: "version", on: "xliff")) {
            try `XLIFF.Document Tests`.parse(text)
        }
    }

    @Test
    func `a root outside the XLIFF namespace is refused`() {
        #expect(throws: XLIFF.Error.unexpectedRoot("xliff")) {
            try `XLIFF.Document Tests`.parse(#"<xliff version="2.1" srcLang="en"/>"#)
        }
        #expect(throws: XLIFF.Error.unexpectedRoot("xliff")) {
            try `XLIFF.Document Tests`.parse(
                #"<xliff xmlns="urn:oasis:names:tc:xliff:document:1.2" version="1.2" srcLang="en"/>"#
            )
        }
    }

    @Test
    func `XML that is not well-formed fails with the XML error`() {
        #expect(throws: XLIFF.Error.xml(.missingRootElement)) {
            try `XLIFF.Document Tests`.parse("")
        }
    }

    @Test
    func `the core namespace may be bound to a prefix`() throws {
        let text = """
            <x:xliff xmlns:x="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">\
            <x:file id="f"><x:unit id="u"><x:segment><x:source>A</x:source></x:segment></x:unit></x:file></x:xliff>
            """
        let document = try `XLIFF.Document Tests`.parse(text)
        #expect(document.version == .v2_0)
        #expect(document.units.map(\.sourceText) == ["A"])
        #expect(try XLIFF.Document(parsing: document.bytes).units == document.units)
    }

    @Test
    func `extension elements keep the namespaces they use when written`() throws {
        let text = """
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" xmlns:my="urn:my" version="2.1" srcLang="en">\
            <file id="f"><my:data my:a="1"><my:item id="x"/></my:data>\
            <unit id="u"><segment><source>A</source></segment></unit></file></xliff>
            """
        let document = try `XLIFF.Document Tests`.parse(text)
        let element = try #require(document.files[0].extensions.elements.first)
        #expect(element.namespaces == [W3C_XML::W3C_XML.Namespace(prefix: "my", uri: "urn:my")])
        #expect(try XLIFF.Document(parsing: document.bytes) == document)
    }

    @Test
    func `comments and processing instructions inside the document are dropped and CDATA becomes text`() throws {
        let document = try `XLIFF.Document Tests`.parse(
            `XLIFF.Document Tests`.document(
                """
                <!-- a comment --><unit id="u"><segment><source>A<!-- x --><?pi data?>B<![CDATA[<C>]]></source>\
                </segment></unit>
                """,
                target: false
            )
        )
        #expect(document.units[0].parts[0].source.content == [.text("AB<C>")])
    }

    @Test
    func `characters XML cannot hold are written as cp and read back as text characters stay`() throws {
        let document = try XLIFF.Document(
            source: BCP47.LanguageTag("en"),
            target: BCP47.LanguageTag("nl"),
            units: [XLIFF.Unit(id: "u", source: "Ctrl+C=\u{3}")]
        )
        let text = String(decoding: document.bytes, as: UTF8.self)
        #expect(text.contains(#"<source>Ctrl+C=<cp hex="0003"/></source>"#))
        let read = try XLIFF.Document(parsing: document.bytes)
        #expect(read.units[0].sourceText == "Ctrl+C=\u{3}")
    }

    @Test
    func `languages are compared without regard to case and xml:lang is inherited`() throws {
        let text = """
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.1" srcLang="en-US" trgLang="nl">\
            <file id="f"><unit id="u"><segment><source xml:lang="en-us">A</source></segment></unit></file></xliff>
            """
        #expect(throws: Never.self) { try `XLIFF.Document Tests`.parse(text) }
        let inherited = """
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.1" srcLang="en" trgLang="nl">\
            <file id="f"><unit id="u" xml:lang="de"><segment><source>A</source></segment></unit></file></xliff>
            """
        #expect(throws: XLIFF.Error.languageMismatch(element: "source", expected: "en", found: "de")) {
            try `XLIFF.Document Tests`.parse(inherited)
        }
    }

    @Test
    func `attributes keep their presence, so a default written explicitly stays written`() throws {
        let document = try `XLIFF.Document Tests`.parse(
            `XLIFF.Document Tests`.document(
                #"<unit id="u" translate="yes"><segment state="initial"><source>A</source></segment></unit>"#,
                target: false
            )
        )
        let text = String(decoding: document.bytes, as: UTF8.self)
        #expect(text.contains(#"<unit id="u" translate="yes">"#))
        #expect(text.contains(#"<segment state="initial">"#))
    }

    @Test
    func `editing hints are errors whatever the state of the segment`() {
        let text = `XLIFF.Document Tests`.document(
            """
            <unit id="u"><segment state="initial"><source><ph id="1" canDelete="no"/>A</source>\
            <target>B</target></segment></unit>
            """
        )
        #expect(throws: XLIFF.Error.missingNonRemovableCode("1")) {
            try `XLIFF.Document Tests`.parse(text)
        }
    }

    @Test
    func `fragment identifiers follow the selector grammar`() throws {
        let fragment = try XLIFF.Fragment(parsing: "#/f=f1/u=u1/t=1")
        #expect(fragment.isAbsolute)
        #expect(fragment.selector("f") == "f1")
        #expect(fragment.selector("t") == "1")
        #expect(throws: XLIFF.Error.invalidFragment("#u=1/f=1")) { try XLIFF.Fragment(parsing: "#u=1/f=1") }
        #expect(throws: XLIFF.Error.invalidFragment("#n=1/u=1")) { try XLIFF.Fragment(parsing: "#n=1/u=1") }
        #expect(throws: XLIFF.Error.invalidFragment("#x=1")) { try XLIFF.Fragment(parsing: "#x=1") }
        #expect(try XLIFF.Fragment(parsing: "#f=f1/tbx=t1").selector("tbx") == "t1")
        #expect(throws: XLIFF.Error.invalidFragment("n=1")) { try XLIFF.Fragment(parsing: "n=1") }
    }
}
