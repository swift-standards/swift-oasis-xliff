import BCP_47

extension XLIFF.Validator {

    struct Context {

        var scope: XLIFF.Scope

        var language: BCP47.LanguageTag?

        var file: XLIFF.Identifier

        var groups: [XLIFF.Identifier]

        var units: Set<XLIFF.Identifier>
    }
}
