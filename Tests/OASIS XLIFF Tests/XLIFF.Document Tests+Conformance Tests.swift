import OASIS_XLIFF
import Testing

extension `XLIFF.Document Tests` {

    static let expected: [String: XLIFF.Error] = [
        "bad_CommentWithValueAndRef.xlf": .invalidCommentAnnotation("4"),
        "bad_ConfusedIsolatedOnEc.xlf": .invalidIsolation("1"),
        "bad_CopyOfWithBadReference.xlf": .unknownReference("not1", attribute: "copyOf"),
        "bad_CopyOfWithNoCopyReference.xlf": .notCopyable("1"),
        "bad_CopyOfWithOriginalData.xlf": .copiedCodeWithData("2"),
        "bad_DataIdNotUnique.xlf": .duplicateIdentifier("d1twice", element: "data"),
        "bad_DataRefWithoutOriginalData.xlf": .unknownReference("d1", attribute: "dataRef"),
        "bad_DifferentCanCopyInScAndEc.xlf": .mismatchedHint("canCopy", code: "1"),
        "bad_DifferentCanDeleteInScAndEc.xlf": .mismatchedHint("canDelete", code: "1"),
        "bad_DifferentCanOverlapInScAndEc.xlf": .mismatchedHint("canOverlap", code: "1"),
        "bad_DifferentCanReorderInScAndEc.xlf": .mismatchedHint("canReorder", code: "1"),
        "bad_DuplicateExtElemIdsInFile.xlf": .duplicateIdentifier("x1", element: "my:elem2"),
        "bad_DuplicateExtElemIdsInGroup.xlf": .duplicateIdentifier("x1", element: "my:elem2"),
        "bad_DuplicateExtElemIdsInUnit.xlf": .duplicateIdentifier("x1", element: "my:elem2"),
        "bad_DuplicateNoteIdsInFile.xlf": .duplicateIdentifier("n1", element: "note"),
        "bad_DuplicateNoteIdsInGroup.xlf": .duplicateIdentifier("n1", element: "note"),
        "bad_DuplicateNoteIdsInUnit.xlf": .duplicateIdentifier("n1", element: "note"),
        "bad_EcBeforeSc.xlf": .unmatchedEnd("1", element: "ec"),
        "bad_EmBeforeSm.xlf": .unmatchedEnd("1", element: "em"),
        "bad_EmptySkeletonWithoutHref.xlf": .invalidSkeleton,
        "bad_FileIdNotUnique.xlf": .duplicateIdentifier("1twice", element: "file"),
        "bad_GroupIdNotUnique.xlf": .duplicateIdentifier("1twice", element: "group"),
        "bad_GroupWithoutId.xlf": .missingAttribute("id", on: "group"),
        "bad_IgnorableIdNotUnique.xlf": .duplicateIdentifier("i1twice", element: "ignorable"),
        "bad_IgnorableWithoutSource.xlf": .unexpectedElement("target", in: "ignorable"),
        "bad_InvalidCommentAnnotation1.xlf": .invalidCommentAnnotation("2"),
        "bad_InvalidCommentAnnotation2.xlf": .invalidCommentAnnotation("2"),
        "bad_InvalidCommentAnnotation3.xlf": .invalidCommentAnnotation("2"),
        "bad_InvalidCommentAnnotation4.xlf": .invalidCommentAnnotation("2"),
        "bad_InvalidDataRef.xlf": .unknownReference("bad", attribute: "dataRef"),
        "bad_InvalidDataRefEnd.xlf": .unknownReference("bad", attribute: "dataRefEnd"),
        "bad_InvalidDataRefStart.xlf": .unknownReference("bad", attribute: "dataRefStart"),
        "bad_InvalidDirAttributeOnSource.xlf": .unexpectedAttribute("dir", on: "source"),
        "bad_InvalidExtensionAttributeOnPc.xlf": .unexpectedAttribute("my:badAttr", on: "pc"),
        "bad_InvalidExtensionAttributeOnSegment.xlf": .unexpectedAttribute("my:badAttr", on: "segment"),
        "bad_InvalidExtensionAttributeOnSource.xlf": .unexpectedAttribute("my:badAttr", on: "source"),
        "bad_InvalidExtensionAttributeOnTarget.xlf": .unexpectedAttribute("my:badAttr", on: "target"),
        "bad_InvalidExtensionElementInData.xlf": .unexpectedElement("my:badElem", in: "data"),
        "bad_InvalidExtensionElementInFile.xlf": .unexpectedElement("my:badElem", in: "file"),
        "bad_InvalidExtensionElementInOriginalData.xlf": .unexpectedElement("my:badElem", in: "originalData"),
        "bad_InvalidExtensionElementInSegment.xlf": .unexpectedElement("my:badElem", in: "segment"),
        "bad_InvalidExtensionElementOutsideFile.xlf": .unexpectedElement("my:badElem", in: "xliff"),
        "bad_InvalidFragIdBadOrder.xlf": .invalidFragment("#/u=u1/f=f1/gls=g1"),
        "bad_InvalidFragIdDuplicatedPrefix.xlf": .invalidFragment("#/u=f1/u=1/gls=g1"),
        "bad_InvalidFragIdMissplacedLeaf.xlf": .invalidFragment("#f=f1/d=d1/u=1"),
        "bad_InvalidFragIdNoSingleLeaf.xlf": .invalidFragment("#c1/c2"),
        "bad_InvalidFragIdPrefixNotNmtoken.xlf": .invalidFragment("#/f=f1/u=1/r$d=myid1"),
        "bad_InvalidFragIdPrefixTooShort.xlf": .invalidFragment("#/f=f1/u=1/z=myid1"),
        "bad_InvalidFragIdSyntax.xlf": .invalidFragment("#n/n1"),
        "bad_InvalidFragIdUnknownPrefix.xlf": .invalidFragment("#/f=f1/u=1/my=myid1"),
        "bad_InvalidHexRangeOnCp.xlf": .invalidValue("00A0", attribute: "hex", on: "cp"),
        "bad_InvalidHexValueOnCp.xlf": .invalidValue("notOK", attribute: "hex", on: "cp"),
        "bad_InvalidId1.xlf": .invalidValue("/1", attribute: "id", on: "unit"),
        "bad_InvalidId2.xlf": .invalidValue("#1", attribute: "id", on: "segment"),
        "bad_InvalidId3.xlf": .invalidValue("\\1", attribute: "id", on: "ph"),
        "bad_InvalidIsolatedOnEc.xlf": .invalidIsolation("1"),
        "bad_InvalidIsolatedOnSc.xlf": .invalidIsolation("1"),
        "bad_InvalidLoneEm.xlf": .unmatchedEnd("m1", element: "em"),
        "bad_InvalidLoneSm.xlf": .unmatchedStart("m1", element: "sm"),
        "bad_InvalidNoteRefInUnit.xlf": .invalidCommentAnnotation("m1"),
        "bad_InvalidNotesInFile.xlf": .unexpectedElement("notes", in: "file"),
        "bad_InvalidNotesInGroup.xlf": .unexpectedElement("notes", in: "group"),
        "bad_InvalidNotesInUnit.xlf": .unexpectedElement("notes", in: "unit"),
        "bad_InvalidStateValue.xlf": .invalidValue("badState", attribute: "state", on: "segment"),
        "bad_InvalidTranslateInSegment.xlf": .unexpectedAttribute("translate", on: "segment"),
        "bad_InvalidTypeSubTypeValues.xlf": .typeMismatch("1"),
        "bad_InvalidTypeValue.xlf": .invalidValue("badType", attribute: "type", on: "pc"),
        "bad_InvalidValidation.xlf": .unexpectedElement("val:validationBad", in: "unit"),
        "bad_InvalidXmlLangInheritedFromFile.xlf": .languageMismatch(element: "source", expected: "en", found: "ja"),
        "bad_InvalidXmlLangInheritedFromGroup.xlf": .languageMismatch(element: "source", expected: "en", found: "ja"),
        "bad_InvalidXmlLangInheritedFromUnit.xlf": .languageMismatch(element: "source", expected: "en", found: "ja"),
        "bad_InvalidXmlLangOnFile.xlf": .languageMismatch(element: "source", expected: "en", found: "ja"),
        "bad_InvalidXmlLangOnGroup.xlf": .languageMismatch(element: "source", expected: "en", found: "ja"),
        "bad_InvalidXmlLangOnUnit.xlf": .languageMismatch(element: "source", expected: "en", found: "ja"),
        "bad_IsolatedEcWithId.xlf": .invalidIsolation("1"),
        "bad_MissingIsolatedOnEc.xlf": .invalidIsolation("1"),
        "bad_MissingIsolatedOnSc.xlf": .unmatchedStart("1", element: "sc"),
        "bad_MissingNonRemovable1.xlf": .missingNonRemovableCode("3"),
        "bad_MissingNonRemovable2.xlf": .missingNonRemovableCode("1"),
        "bad_MissingReorderFirstNo.xlf": .nonReorderableSequence("1"),
        "bad_NoFile.xlf": .missingElement("file", in: "xliff"),
        "bad_NoTrgLang.xlf": .missingTargetLanguage,
        "bad_NoTrgLangWithIgnorable.xlf": .missingTargetLanguage,
        "bad_NoUnitOrGroupInFile.xlf": .missingElement("unit", in: "file"),
        "bad_NonEmptySkeletonWithHref.xlf": .invalidSkeleton,
        "bad_NonIsolatedEcWithoutStartRef.xlf": .invalidIsolation("1"),
        "bad_NotesWithoutNote.xlf": .missingElement("note", in: "notes"),
        "bad_OrderNotUnique1.xlf": .invalidOrder(1, unit: "1"),
        "bad_OrderNotUnique2.xlf": .invalidOrder(2, unit: "1"),
        "bad_OriginalDataWithoutData.xlf": .missingElement("data", in: "originalData"),
        "bad_PartIdNotUnique.xlf": .duplicateIdentifier("1twice", element: "ignorable"),
        "bad_RefAndValueInComment.xlf": .invalidCommentAnnotation("1"),
        "bad_SegmentIdNotUnique.xlf": .duplicateIdentifier("s1twice", element: "segment"),
        "bad_SegmentWithoutSource.xlf": .unexpectedElement("target", in: "segment"),
        "bad_SrcLangNotWellFormed.xlf": .invalidValue("e", attribute: "srcLang", on: "xliff"),
        "bad_SubFlowWithInvalidReference.xlf": .unknownReference("badRef", attribute: "subFlowsStart"),
        "bad_SubFlowWithInvalidValue.xlf": .invalidValue("tu7,", attribute: "subFlows", on: "ph"),
        "bad_SubStateWithoutState.xlf": .subStateWithoutState,
        "bad_SubTypeWithoutType.xlf": .subTypeWithoutType("1"),
        "bad_TrgLangNotWellFormed.xlf": .invalidValue("f r", attribute: "trgLang", on: "xliff"),
        "bad_TwoSourceInUnit.xlf": .unexpectedElement("source", in: "segment"),
        "bad_UnitWithoutSegment.xlf": .missingElement("segment", in: "unit"),
        "bad_UnknownDataRefEndValue.xlf": .unknownReference("badId", attribute: "dataRefEnd"),
        "bad_UnknownDataRefStartValue.xlf": .unknownReference("badId", attribute: "dataRefStart"),
        "bad_UnknownDataRefValue.xlf": .unknownReference("badId", attribute: "dataRef"),
        "bad_WrongLangOnTarget.xlf": .languageMismatch(element: "target", expected: "fr", found: "ja"),
        "bad_WrongReordering1.xlf": .nonReorderableSequence("3"),
        "bad_WrongReordering2.xlf": .nonReorderableSequence("1"),
        "bad_WrongSourceLang.xlf": .languageMismatch(element: "source", expected: "en", found: "ja"),
        "bad_WrongTargetLang.xlf": .languageMismatch(element: "target", expected: "fr", found: "de"),
        "bad_XmlLangNotWellFormed.xlf": .invalidValue("f r", attribute: "xml:lang", on: "target"),
        "bad_YesCanReorderInEcForFirstNoInSc.xlf": .mismatchedHint("canReorder", code: "1"),
        "bad_canReorderContext1.xlf": .invalidHints("1"),
        "bad_canReorderContext2.xlf": .invalidHints("1"),
        "bad_canReorderContext3.xlf": .invalidHints("1"),
    ]

    static let registered: [String: String] = [
        "tbx": "urn:iso:std:iso:30042:ed-1:v1:en",
        "gls": "testGLSv2.x",
        "my": "myNS",
    ]

    static let modulesBreakingCore: [String: XLIFF.Error] = [
        "Bad-slr_equivStorage-ec-not-isolated.xlf": .unmatchedStart("1", element: "sc")
    ]

    static let accepted: Set<String> = [
        "bad_DifferentXmlSpace.xlf",
        "bad_InvalidFSAttribute.xlf",
        "bad_InvalidFSAttributeOnEc.xlf",
        "bad_InvalidFSAttributeValue.xlf",
    ]
}

extension `XLIFF.Document Tests`.Test.Integration {

    @Test(arguments: `XLIFF.Document Tests`.valid)
    func `every valid document of the OASIS test suite is read and its bytes read back to an equal document`(
        fixture: `XLIFF.Document Tests`.Fixture
    ) throws {
        let prefixes = `XLIFF.Document Tests`.registered
        let document = try XLIFF.Document(parsing: fixture.bytes, prefixes: prefixes)
        #expect(try XLIFF.Document(parsing: document.bytes, prefixes: prefixes) == document)
    }

    @Test(arguments: `XLIFF.Document Tests`.invalid)
    func `every invalid core document of the OASIS test suite fails with the error it was written for`(
        fixture: `XLIFF.Document Tests`.Fixture
    ) throws {
        let name = String(fixture.name.split(separator: "/").last ?? "")
        if `XLIFF.Document Tests`.accepted.contains(name) {
            #expect(throws: Never.self) { try XLIFF.Document(parsing: fixture.bytes) }
        } else {
            let expected = try #require(`XLIFF.Document Tests`.expected[name])
            #expect(throws: expected) { try XLIFF.Document(parsing: fixture.bytes) }
        }
    }

    @Test
    func `the expectations cover every invalid core document`() {
        let names = Set(`XLIFF.Document Tests`.invalid.map { String($0.name.split(separator: "/").last ?? "") })
        #expect(names == Set(`XLIFF.Document Tests`.expected.keys).union(`XLIFF.Document Tests`.accepted))
    }

    @Test(arguments: `XLIFF.Document Tests`.modulesInvalid)
    func `module documents the OASIS suite marks invalid are read unless they also break XLIFF Core`(
        fixture: `XLIFF.Document Tests`.Fixture
    ) {
        let name = String(fixture.name.split(separator: "/").last ?? "")
        if let expected = `XLIFF.Document Tests`.modulesBreakingCore[name] {
            #expect(throws: expected) { try XLIFF.Document(parsing: fixture.bytes) }
        } else {
            #expect(throws: Never.self) { try XLIFF.Document(parsing: fixture.bytes) }
        }
    }
}
