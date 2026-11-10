extension XLIFF {

    public struct Fragment: Sendable, Hashable {

        public let isAbsolute: Bool

        public let selectors: [Selector]

        public init(parsing text: String) throws(XLIFF.Error) {
            guard text.hasPrefix("#") else { throw .invalidFragment(text) }
            var body = Substring(text.dropFirst())
            isAbsolute = body.hasPrefix("/")
            if isAbsolute {
                body = body.dropFirst()
            }
            var selectors: [Selector] = []
            for part in body.split(separator: "/", omittingEmptySubsequences: false) {
                let pieces = part.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
                let selector =
                    pieces.count == 2
                    ? Selector(prefix: String(pieces[0]), id: XLIFF.Identifier(String(pieces[1])))
                    : Selector(prefix: nil, id: XLIFF.Identifier(String(part)))
                guard selector.id.isToken, selector.prefix.map(\.isToken) ?? true else {
                    throw .invalidFragment(text)
                }
                selectors.append(selector)
            }
            guard !selectors.isEmpty else { throw .invalidFragment(text) }
            let prefixes = selectors.map { $0.prefix ?? "" }
            guard Set(prefixes).count == prefixes.count else { throw .invalidFragment(text) }
            let structural = ["f", "g", "u"]
            var rank = -1
            for (index, selector) in selectors.enumerated() {
                if let position = structural.firstIndex(of: selector.prefix ?? "") {
                    guard position > rank else { throw .invalidFragment(text) }
                    rank = position
                } else {
                    guard index == selectors.indices.last else { throw .invalidFragment(text) }
                    if let prefix = selector.prefix, !["n", "d", "t"].contains(prefix) {
                        guard prefix.count > 1 else { throw .invalidFragment(text) }
                    }
                }
            }
            self.selectors = selectors
        }
    }
}

extension XLIFF.Fragment {

    public func selector(_ prefix: String?) -> XLIFF.Identifier? {
        selectors.first { $0.prefix == prefix }?.id
    }
}

extension String {

    fileprivate var isToken: Bool {
        XLIFF.Identifier(self).isToken
    }
}
