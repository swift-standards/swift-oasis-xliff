extension XLIFF {

    public enum Node: Sendable, Hashable {

        case unit(XLIFF.Unit)

        case group(XLIFF.Group)
    }
}

extension [XLIFF.Node] {

    var units: [XLIFF.Unit] {
        var result: [XLIFF.Unit] = []
        for node in self {
            switch node {
            case .unit(let unit): result.append(unit)
            case .group(let group): result += group.nodes.units
            }
        }
        return result
    }
}
