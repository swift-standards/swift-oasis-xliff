extension XLIFF {

    public indirect enum Inline: Sendable, Hashable {

        case text(String)

        case codePoint(XLIFF.CodePoint)

        case standalone(XLIFF.Code.Standalone)

        case spanning(XLIFF.Code.Spanning)

        case start(XLIFF.Code.Start)

        case end(XLIFF.Code.End)

        case annotation(XLIFF.Annotation)

        case annotationStart(XLIFF.Annotation.Start)

        case annotationEnd(XLIFF.Annotation.End)
    }
}

extension XLIFF.Inline {

    public static func content(_ text: String) -> [XLIFF.Inline] {
        var result: [XLIFF.Inline] = []
        var run = ""
        for scalar in XLIFF.scalars(text) {
            if W3C_XML::W3C_XML.isChar(scalar) {
                run.unicodeScalars.append(scalar)
            } else {
                if !run.isEmpty {
                    result.append(.text(run))
                    run = ""
                }
                result.append(.codePoint(XLIFF.CodePoint(scalar.value)))
            }
        }
        if !run.isEmpty {
            result.append(.text(run))
        }
        return result
    }
}

extension [XLIFF.Inline] {

    var plainText: String {
        var result = ""
        for item in self {
            switch item {
            case .text(let text):
                result += text

            case .codePoint(let point):
                result.unicodeScalars.append(point.scalar ?? "\u{FFFD}")

            case .standalone(let code):
                result += code.equivalent ?? ""

            case .spanning(let code):
                result += code.equivalentStart ?? ""
                result += code.content.plainText
                result += code.equivalentEnd ?? ""

            case .start(let code):
                result += code.equivalent ?? ""

            case .end(let code):
                result += code.equivalent ?? ""

            case .annotation(let annotation):
                result += annotation.content.plainText

            case .annotationStart, .annotationEnd:
                break
            }
        }
        return result
    }
}
