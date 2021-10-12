// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CoreUI",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(name: "CoreUI", targets: ["CoreUI"])
  ],
  dependencies: [
    .package(name: "CoreKit", url: "https://github.com/mr-noone/core-kit.git", .branch("develop")),
    .package(name: "RouteKit", url: "https://github.com/mr-noone/route-kit.git", from: "2.1.1"),
    .package(name: "DiffKit", url: "https://github.com/mr-noone/diff-kit.git", from: "2.0.0"),
    .package(name: "Nibble", url: "https://github.com/mr-noone/nibble.git", from: "1.1.0"),
    .package(name: "Then", url: "https://github.com/devxoul/Then", from: "2.7.0")
  ],
  targets: [
    .target(name: "CoreUI", dependencies: ["CoreKit", "RouteKit", "DiffKit", "Nibble", "Then"])
  ]
)
