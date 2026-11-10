extension XLIFF {

    enum Namespace {}
}

extension XLIFF.Namespace {

    static let core = "urn:oasis:names:tc:xliff:document:2.0"

    static let xml = "http://www.w3.org/XML/1998/namespace"

    static let formatStyle = "urn:oasis:names:tc:xliff:fs:2.0"

    static let sizeRestriction = "urn:oasis:names:tc:xliff:sizerestriction:2.0"

    static let metadata = "urn:oasis:names:tc:xliff:metadata:2.0"

    static let resourceData = "urn:oasis:names:tc:xliff:resourcedata:2.0"

    static let validation = "urn:oasis:names:tc:xliff:validation:2.0"

    static let matches = "urn:oasis:names:tc:xliff:matches:2.0"

    static let glossary = "urn:oasis:names:tc:xliff:glossary:2.0"

    static let its = "http://www.w3.org/2005/11/its"

    static let itsMapping = "urn:oasis:names:tc:xliff:itsm:2.1"
}

extension XLIFF.Namespace {

    static func moduleElements(at point: Point) -> [String: [String: Int?]] {
        switch point {
        case .file:
            [
                metadata: ["metadata": 1],
                resourceData: ["resourceData": 1],
                sizeRestriction: ["profiles": 1, "data": 1],
                validation: ["validation": 1],
                its: ["provenanceRecords": nil],
                matches: [:],
                glossary: [:],
                formatStyle: [:],
                itsMapping: [:],
            ]

        case .group:
            [
                metadata: ["metadata": 1],
                resourceData: [:],
                sizeRestriction: ["data": 1],
                validation: ["validation": 1],
                its: ["provenanceRecords": nil],
                matches: [:],
                glossary: [:],
                formatStyle: [:],
                itsMapping: [:],
            ]

        case .unit:
            [
                metadata: ["metadata": 1],
                resourceData: ["resourceData": 1],
                sizeRestriction: ["data": 1],
                validation: ["validation": 1],
                its: ["provenanceRecords": nil, "locQualityIssues": nil],
                matches: ["matches": 1],
                glossary: ["glossary": 1],
                formatStyle: [:],
                itsMapping: [:],
            ]
        }
    }

    static let fragmentPrefixes: Set<String> = ["mtc", "gls", "mda", "res", "ctr", "slr", "val", "its"]

    static let codeAttributes: Set<String> = [formatStyle, sizeRestriction]
}
