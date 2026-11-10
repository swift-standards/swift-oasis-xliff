// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-oasis-xliff",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "OASIS XLIFF", targets: ["OASIS XLIFF"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-w3c/swift-w3c-xml.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-bcp-47.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3987.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "OASIS XLIFF",
            dependencies: [
                .product(name: "W3C XML", package: "swift-w3c-xml"),
                .product(name: "BCP 47", package: "swift-bcp-47"),
                .product(name: "RFC 3987", package: "swift-rfc-3987"),
            ]
        ),
        .testTarget(
            name: "OASIS XLIFF Tests",
            dependencies: [
                .target(name: "OASIS XLIFF")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableExperimentalFeature("Lifetimes"),
            .treatAllWarnings(as: .error),
        ]
}
