extension XLIFF.Code {

    public struct Start: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var isolated: Bool?

        public var canCopy: Bool?

        public var canDelete: Bool?

        public var canOverlap: Bool?

        public var canReorder: Reorder?

        public var copyOf: XLIFF.Identifier?

        public var display: String?

        public var equivalent: String?

        public var data: XLIFF.Identifier?

        public var subFlows: [XLIFF.Identifier]?

        public var type: Kind?

        public var subType: String?

        public var direction: XLIFF.Direction?

        public var extensions: XLIFF.Extensions

        public init(
            id: XLIFF.Identifier,
            isolated: Bool? = nil,
            canCopy: Bool? = nil,
            canDelete: Bool? = nil,
            canOverlap: Bool? = nil,
            canReorder: Reorder? = nil,
            copyOf: XLIFF.Identifier? = nil,
            display: String? = nil,
            equivalent: String? = nil,
            data: XLIFF.Identifier? = nil,
            subFlows: [XLIFF.Identifier]? = nil,
            type: Kind? = nil,
            subType: String? = nil,
            direction: XLIFF.Direction? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions()
        ) {
            self.id = id
            self.isolated = isolated
            self.canCopy = canCopy
            self.canDelete = canDelete
            self.canOverlap = canOverlap
            self.canReorder = canReorder
            self.copyOf = copyOf
            self.display = display
            self.equivalent = equivalent
            self.data = data
            self.subFlows = subFlows
            self.type = type
            self.subType = subType
            self.direction = direction
            self.extensions = extensions
        }
    }
}
