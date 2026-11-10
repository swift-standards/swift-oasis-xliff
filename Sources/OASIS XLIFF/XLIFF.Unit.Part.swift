extension XLIFF.Unit {

    public enum Part: Sendable, Hashable {

        case segment(XLIFF.Segment)

        case ignorable(XLIFF.Ignorable)
    }
}

extension XLIFF.Unit.Part {

    public var id: XLIFF.Identifier? {
        switch self {
        case .segment(let segment): segment.id
        case .ignorable(let ignorable): ignorable.id
        }
    }

    public var source: XLIFF.Source {
        switch self {
        case .segment(let segment): segment.source
        case .ignorable(let ignorable): ignorable.source
        }
    }

    public var target: XLIFF.Target? {
        switch self {
        case .segment(let segment): segment.target
        case .ignorable(let ignorable): ignorable.target
        }
    }
}
