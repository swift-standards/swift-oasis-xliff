extension XLIFF.Validator {

    struct Event: Equatable {

        let key: String

        let id: XLIFF.Identifier

        let reorder: XLIFF.Code.Reorder
    }
}
