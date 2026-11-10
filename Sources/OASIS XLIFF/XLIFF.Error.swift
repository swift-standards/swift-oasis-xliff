public import W3C_XML

extension XLIFF {

    public enum Error: Swift::Error, Sendable, Equatable {

        case xml(W3C_XML::W3C_XML.Parse.Error)

        case unexpectedRoot(String)

        case unexpectedElement(String, in: String)

        case unexpectedText(in: String)

        case missingElement(String, in: String)

        case unexpectedAttribute(String, on: String)

        case missingAttribute(String, on: String)

        case invalidValue(String, attribute: String, on: String)

        case undeclaredPrefix(String)

        case invalidCharacter(in: String)

        case duplicateIdentifier(XLIFF.Identifier, element: String)

        case missingTargetLanguage

        case languageMismatch(element: String, expected: String, found: String)

        case invalidSkeleton

        case unknownReference(XLIFF.Identifier, attribute: String)

        case unpairedAttribute(String, on: String)

        case unmatchedStart(XLIFF.Identifier, element: String)

        case unmatchedEnd(XLIFF.Identifier, element: String)

        case invalidIsolation(XLIFF.Identifier)

        case mismatchedHint(String, code: XLIFF.Identifier)

        case invalidHints(XLIFF.Identifier)

        case nonReorderableSequence(XLIFF.Identifier)

        case missingNonRemovableCode(XLIFF.Identifier)

        case notCopyable(XLIFF.Identifier)

        case copiedCodeWithData(XLIFF.Identifier)

        case invalidOrder(UInt, unit: XLIFF.Identifier)

        case stateWithoutTarget(XLIFF.State)

        case subStateWithoutState

        case subTypeWithoutType(XLIFF.Identifier)

        case typeMismatch(XLIFF.Identifier)

        case invalidCommentAnnotation(XLIFF.Identifier)

        case invalidFragment(String)
    }
}
