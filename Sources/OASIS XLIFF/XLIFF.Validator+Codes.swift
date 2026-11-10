extension XLIFF.Validator {

    func pairing(_ content: [XLIFF.Inline]) throws(XLIFF.Error) {
        var open: [XLIFF.Identifier: XLIFF.Code.Start] = [:]
        var isolated: Set<XLIFF.Identifier> = []
        var markers: Set<XLIFF.Identifier> = []
        var startOrder: [XLIFF.Identifier] = []
        var markerOrder: [XLIFF.Identifier] = []
        for item in content {
            switch item {
            case .start(let code):
                if code.isolated == true {
                    isolated.insert(code.id)
                } else {
                    open[code.id] = code
                    startOrder.append(code.id)
                }

            case .end(let code):
                if code.isolated == true {
                    guard code.id != nil, code.startReference == nil else {
                        throw .invalidIsolation(code.id ?? code.startReference ?? "")
                    }
                } else {
                    guard let reference = code.startReference, code.id == nil else {
                        throw .invalidIsolation(code.id ?? code.startReference ?? "")
                    }
                    guard code.direction == nil else { throw .unexpectedAttribute("dir", on: "ec") }
                    guard !isolated.contains(reference) else { throw .invalidIsolation(reference) }
                    guard let start = open.removeValue(forKey: reference) else {
                        throw .unmatchedEnd(reference, element: "ec")
                    }
                    try agree(start, code, reference)
                }

            case .annotationStart(let annotation):
                markers.insert(annotation.id)
                markerOrder.append(annotation.id)

            case .annotationEnd(let annotation):
                guard markers.remove(annotation.startReference) != nil else {
                    throw .unmatchedEnd(annotation.startReference, element: "em")
                }

            default:
                break
            }
        }
        if let id = startOrder.first(where: { open[$0] != nil }) {
            throw .unmatchedStart(id, element: "sc")
        }
        if let id = markerOrder.first(where: markers.contains) {
            throw .unmatchedStart(id, element: "sm")
        }
    }

    func agree(_ start: XLIFF.Code.Start, _ end: XLIFF.Code.End, _ id: XLIFF.Identifier) throws(XLIFF.Error) {
        guard (start.canCopy ?? true) == (end.canCopy ?? true) else {
            throw .mismatchedHint("canCopy", code: id)
        }
        guard (start.canDelete ?? true) == (end.canDelete ?? true) else {
            throw .mismatchedHint("canDelete", code: id)
        }
        guard (start.canOverlap ?? true) == (end.canOverlap ?? true) else {
            throw .mismatchedHint("canOverlap", code: id)
        }
        let expected: XLIFF.Code.Reorder = start.canReorder == .firstNo ? .no : start.canReorder ?? .yes
        guard (end.canReorder ?? .yes) == expected else {
            throw .mismatchedHint("canReorder", code: id)
        }
    }

    func identifiers(_ unit: XLIFF.Unit) throws(XLIFF.Error) {
        var sources: [XLIFF.Identifier: Int] = [:]
        for part in unit.parts {
            if let id = part.id {
                sources[id, default: 0] += 1
                if sources[id] ?? 0 > 1 {
                    throw .duplicateIdentifier(id, element: part.element)
                }
            }
            for item in Self.flattened(part.source.content) {
                if let (id, element) = Self.identity(item) {
                    sources[id, default: 0] += 1
                    if sources[id] ?? 0 > 1 {
                        throw .duplicateIdentifier(id, element: element)
                    }
                }
            }
        }
        var targets: [XLIFF.Identifier: Int] = [:]
        for part in unit.parts {
            for item in Self.flattened(part.target?.content ?? []) {
                if let (id, _) = Self.identity(item) {
                    targets[id, default: 0] += 1
                }
            }
        }
        for part in unit.parts {
            guard let target = part.target else { continue }
            let siblings = Self.flattened(part.source.content).compactMap(Self.identity)
            for item in Self.flattened(target.content) {
                guard let (id, element) = Self.identity(item) else { continue }
                let count = (sources[id] ?? 0) + (targets[id] ?? 0)
                let corresponding = siblings.filter { $0.id == id && $0.element == element }.count == 1
                guard count == 1 || (count == 2 && corresponding) else {
                    throw .duplicateIdentifier(id, element: element)
                }
            }
        }
    }

    func references(_ unit: XLIFF.Unit, data: Set<XLIFF.Identifier>, context: Context) throws(XLIFF.Error) {
        let all = unit.parts.flatMap { part in
            Self.flattened(part.source.content) + Self.flattened(part.target?.content ?? [])
        }
        func reference(_ id: XLIFF.Identifier?, _ attribute: String) throws(XLIFF.Error) {
            guard let id else { return }
            guard data.contains(id) else { throw .unknownReference(id, attribute: attribute) }
        }
        func flows(_ ids: [XLIFF.Identifier]?, _ attribute: String, on element: String) throws(XLIFF.Error) {
            guard let ids else { return }
            for id in ids {
                guard id.isToken else { throw .invalidValue(id.value, attribute: attribute, on: element) }
                guard context.units.contains(id) else { throw .unknownReference(id, attribute: attribute) }
            }
        }
        for item in all {
            switch item {
            case .standalone(let code):
                try reference(code.data, "dataRef")
                try flows(code.subFlows, "subFlows", on: "ph")
                try copy(code.copyOf, in: all)

            case .spanning(let code):
                try reference(code.dataStart, "dataRefStart")
                try reference(code.dataEnd, "dataRefEnd")
                try flows(code.subFlowsStart, "subFlowsStart", on: "pc")
                try flows(code.subFlowsEnd, "subFlowsEnd", on: "pc")
                try paired(code.subFlowsStart != nil, code.subFlowsEnd != nil, "subFlowsStart", "subFlowsEnd")
                try copy(code.copyOf, in: all)

            case .start(let code):
                try reference(code.data, "dataRef")
                try flows(code.subFlows, "subFlows", on: "sc")
                try copy(code.copyOf, in: all)

            case .end(let code):
                try reference(code.data, "dataRef")
                try flows(code.subFlows, "subFlows", on: "ec")
                try copy(code.copyOf, in: all)

            default:
                break
            }
        }
    }

    func copy(_ base: XLIFF.Identifier?, in all: [XLIFF.Inline]) throws(XLIFF.Error) {
        guard let base else { return }
        try identifier(base, on: "copyOf")
        var found = false
        var hasData = true
        for item in all {
            switch item {
            case .standalone(let code) where code.id == base:
                found = true
                if code.canCopy == false { throw .notCopyable(base) }
                hasData = hasData && code.data != nil

            case .spanning(let code) where code.id == base:
                found = true
                if code.canCopy == false { throw .notCopyable(base) }
                hasData = hasData && (code.dataStart != nil || code.dataEnd != nil)

            case .start(let code) where code.id == base:
                found = true
                if code.canCopy == false { throw .notCopyable(base) }
                hasData = hasData && code.data != nil

            case .end(let code) where code.id == base:
                found = true
                if code.canCopy == false { throw .notCopyable(base) }
                hasData = hasData && code.data != nil

            default:
                break
            }
        }
        guard found else { throw .unknownReference(base, attribute: "copyOf") }
        guard !hasData else { throw .notCopyable(base) }
    }

    func order(_ unit: XLIFF.Unit) throws(XLIFF.Error) {
        var taken: Set<UInt> = []
        for (index, part) in unit.parts.enumerated() {
            let position = part.target?.order ?? UInt(index + 1)
            guard (1...UInt(unit.parts.count)).contains(position), taken.insert(position).inserted else {
                throw .invalidOrder(position, unit: unit.id)
            }
        }
    }
}

extension XLIFF.Unit.Part {

    var element: String {
        switch self {
        case .segment: "segment"
        case .ignorable: "ignorable"
        }
    }
}
