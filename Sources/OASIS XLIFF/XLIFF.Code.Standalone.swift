extension XLIFF.Code {

    public struct Standalone: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var canCopy: Bool?

        public var canDelete: Bool?

        public var canReorder: Reorder?

        public var copyOf: XLIFF.Identifier?

        public var display: String?

        public var equivalent: String?

        public var data: XLIFF.Identifier?

        public var subFlows: [XLIFF.Identifier]?

        public var type: Kind?

        public var subType: String?

        public var extensions: XLIFF.Extensions

        public init(
            id: XLIFF.Identifier,
            canCopy: Bool? = nil,
            canDelete: Bool? = nil,
            canReorder: Reorder? = nil,
            copyOf: XLIFF.Identifier? = nil,
            display: String? = nil,
            equivalent: String? = nil,
            data: XLIFF.Identifier? = nil,
            subFlows: [XLIFF.Identifier]? = nil,
            type: Kind? = nil,
            subType: String? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions()
        ) {
            self.id = id
            self.canCopy = canCopy
            self.canDelete = canDelete
            self.canReorder = canReorder
            self.copyOf = copyOf
            self.display = display
            self.equivalent = equivalent
            self.data = data
            self.subFlows = subFlows
            self.type = type
            self.subType = subType
            self.extensions = extensions
        }
    }
}
