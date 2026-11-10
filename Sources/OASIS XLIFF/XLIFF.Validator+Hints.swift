extension XLIFF.Validator {

    static func events(_ content: [XLIFF.Inline]) -> [Event] {
        var result: [Event] = []
        for item in content {
            switch item {
            case .standalone(let code):
                result.append(Event(key: "ph " + code.id.value, id: code.id, reorder: code.canReorder ?? .yes))

            case .spanning(let code):
                let reorder = code.canReorder ?? .yes
                result.append(Event(key: "pc " + code.id.value, id: code.id, reorder: reorder))
                result += events(code.content)
                result.append(
                    Event(key: "/pc " + code.id.value, id: code.id, reorder: reorder == .firstNo ? .no : reorder)
                )

            case .start(let code):
                result.append(Event(key: "sc " + code.id.value, id: code.id, reorder: code.canReorder ?? .yes))

            case .end(let code):
                let id = code.startReference ?? code.id ?? ""
                result.append(Event(key: "ec " + id.value, id: id, reorder: code.canReorder ?? .yes))

            case .annotation(let annotation):
                result += events(annotation.content)

            default:
                break
            }
        }
        return result
    }

    static func sequences(_ events: [Event]) -> [[Event]] {
        var result: [[Event]] = []
        var current: [Event] = []
        for event in events {
            switch event.reorder {
            case .firstNo:
                if current.count > 1 { result.append(current) }
                current = [event]

            case .no:
                current.append(event)

            case .yes:
                if current.count > 1 { result.append(current) }
                current = []
            }
        }
        if current.count > 1 { result.append(current) }
        return result
    }

    func hints(_ unit: XLIFF.Unit) throws(XLIFF.Error) {
        for side in [unit.parts.map(\.source.content), unit.parts.compactMap(\.target?.content)] {
            var previous: XLIFF.Code.Reorder?
            for event in Self.events(side.flatMap { $0 }) {
                if event.reorder == .no, previous == nil || previous == .yes {
                    throw .nonReorderableSequence(event.id)
                }
                previous = event.reorder
            }
        }
        for part in unit.parts {
            guard let target = part.target else { continue }
            let keys = Self.events(target.content).map(\.key)
            for sequence in Self.sequences(Self.events(part.source.content)) {
                let expected = sequence.map(\.key)
                let found = keys.indices.contains { start in
                    start + expected.count <= keys.count && Array(keys[start..<start + expected.count]) == expected
                }
                guard found else { throw .nonReorderableSequence(sequence[0].id) }
            }
            let present = Set(Self.flattened(target.content).compactMap(Self.removal))
            for item in Self.flattened(part.source.content) {
                guard let key = Self.removal(item), Self.canDelete(item) == false else { continue }
                guard present.contains(key) else { throw .missingNonRemovableCode(key.id) }
            }
        }
    }

    static func removal(_ item: XLIFF.Inline) -> Removal? {
        switch item {
        case .standalone(let code): Removal(element: "ph", id: code.id)
        case .spanning(let code): Removal(element: "pc", id: code.id)
        case .start(let code): Removal(element: "sc", id: code.id)
        case .end(let code): (code.startReference ?? code.id).map { Removal(element: "ec", id: $0) }
        default: nil
        }
    }

    static func canDelete(_ item: XLIFF.Inline) -> Bool? {
        switch item {
        case .standalone(let code): code.canDelete
        case .spanning(let code): code.canDelete
        case .start(let code): code.canDelete
        case .end(let code): code.canDelete
        default: nil
        }
    }
}
