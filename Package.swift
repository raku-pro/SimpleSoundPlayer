// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let name = "SimpleSoundPlayer"
private let targetName = name

let package = Package(
    name: name,
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: name,
            targets: [targetName]),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: targetName,
            path: "Sources/SimpleSoundPlayer",
            sources: ["SimpleSoundPlayer.swift"])
    ]
)
