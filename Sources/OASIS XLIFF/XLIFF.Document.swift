public import BCP_47
public import W3C_XML

extension XLIFF {

    public struct Document: Sendable, Hashable {

        public var version: XLIFF.Version

        public var sourceLanguage: BCP47.LanguageTag

        public var targetLanguage: BCP47.LanguageTag?

        public var space: XLIFF.Space?

        public var language: BCP47.LanguageTag?

        public var extensions: XLIFF.Extensions

        public var files: [XLIFF.File]

        public var prologue: [W3C_XML::W3C_XML.Content]

        public var epilogue: [W3C_XML::W3C_XML.Content]

        public init(
            version: XLIFF.Version = .v2_1,
            sourceLanguage: BCP47.LanguageTag,
            targetLanguage: BCP47.LanguageTag? = nil,
            space: XLIFF.Space? = nil,
            language: BCP47.LanguageTag? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions(),
            files: [XLIFF.File],
            prologue: [W3C_XML::W3C_XML.Content] = [],
            epilogue: [W3C_XML::W3C_XML.Content] = []
        ) {
            self.version = version
            self.sourceLanguage = sourceLanguage
            self.targetLanguage = targetLanguage
            self.space = space
            self.language = language
            self.extensions = extensions
            self.files = files
            self.prologue = prologue
            self.epilogue = epilogue
        }
    }
}

extension XLIFF.Document {

    public init(
        source: BCP47.LanguageTag,
        target: BCP47.LanguageTag,
        file: XLIFF.Identifier = "f1",
        units: [XLIFF.Unit]
    ) throws(XLIFF.Error) {
        self.init(
            sourceLanguage: source,
            targetLanguage: target,
            files: [XLIFF.File(id: file, nodes: units.map(XLIFF.Node.unit))]
        )
        try validate()
    }
}

extension XLIFF.Document {

    public var units: [XLIFF.Unit] {
        files.flatMap(\.units)
    }

    public var targets: [XLIFF.Identifier: String] {
        var result: [XLIFF.Identifier: String] = [:]
        var seen: Set<XLIFF.Identifier> = []
        for unit in units where seen.insert(unit.id).inserted {
            if let text = unit.targetText {
                result[unit.id] = text
            }
        }
        return result
    }

    public func target(of unit: XLIFF.Identifier) -> String? {
        units.first { $0.id == unit }?.targetText
    }
}
