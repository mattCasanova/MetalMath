// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "MetalMath",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "MetalMath",
            targets: ["MetalMath"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", from: "0.63.2"),
    ],
    targets: [
        .target(
            name: "MetalMath",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
            ]),
        .testTarget(
            name: "MetalMathTests",
            dependencies: ["MetalMath"]),
    ]
)
