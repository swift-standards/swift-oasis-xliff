extension XLIFF.Code {

    public struct Spanning: Sendable, Hashable {

        public var id: XLIFF.Identifier

        public var canCopy: Bool?

        public var canDelete: Bool?

        public var canOverlap: Bool?

        public var canReorder: Reorder?

        public var copyOf: XLIFF.Identifier?

        public var displayStart: String?

        public var displayEnd: String?

        public var equivalentStart: String?

        public var equivalentEnd: String?

        public var dataStart: XLIFF.Identifier?

        public var dataEnd: XLIFF.Identifier?

        public var subFlowsStart: [XLIFF.Identifier]?

        public var subFlowsEnd: [XLIFF.Identifier]?

        public var type: Kind?

        public var subType: String?

        public var direction: XLIFF.Direction?

        public var extensions: XLIFF.Extensions

        public var content: [XLIFF.Inline]

        public init(
            id: XLIFF.Identifier,
            canCopy: Bool? = nil,
            canDelete: Bool? = nil,
            canOverlap: Bool? = nil,
            canReorder: Reorder? = nil,
            copyOf: XLIFF.Identifier? = nil,
            displayStart: String? = nil,
            displayEnd: String? = nil,
            equivalentStart: String? = nil,
            equivalentEnd: String? = nil,
            dataStart: XLIFF.Identifier? = nil,
            dataEnd: XLIFF.Identifier? = nil,
            subFlowsStart: [XLIFF.Identifier]? = nil,
            subFlowsEnd: [XLIFF.Identifier]? = nil,
            type: Kind? = nil,
            subType: String? = nil,
            direction: XLIFF.Direction? = nil,
            extensions: XLIFF.Extensions = XLIFF.Extensions(),
            content: [XLIFF.Inline] = []
        ) {
            self.id = id
            self.canCopy = canCopy
            self.canDelete = canDelete
            self.canOverlap = canOverlap
            self.canReorder = canReorder
            self.copyOf = copyOf
            self.displayStart = displayStart
            self.displayEnd = displayEnd
            self.equivalentStart = equivalentStart
            self.equivalentEnd = equivalentEnd
            self.dataStart = dataStart
            self.dataEnd = dataEnd
            self.subFlowsStart = subFlowsStart
            self.subFlowsEnd = subFlowsEnd
            self.type = type
            self.subType = subType
            self.direction = direction
            self.extensions = extensions
            self.content = content
        }
    }
}
