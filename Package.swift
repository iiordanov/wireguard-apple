// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WireGuardKit",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12)
    ],
    products: [
        .library(name: "WireGuardKit", targets: ["WireGuardKit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WireGuardKit",
            dependencies: [ "WireGuardAppMain", "WireGuardAppTunnel", "WireGuardKitC", "WireGuardKitGo", "WireGuardNetworkExtension" ]
        ),
        .target(
            name: "WireGuardAppMain",
            dependencies: [],
            path: "Sources/WireGuardApp",
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardAppTunnel",
            dependencies: ["WireGuardAppMain"],
            path: "Sources/WireGuardApp/Tunnel",
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardKitC",
            dependencies: [],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardKitGo",
            dependencies: [],
            exclude: [
                "goruntime-boottime-over-monotonic.diff",
                "go.mod",
                "go.sum",
                "api-apple.go",
                "Makefile"
            ],
            publicHeadersPath: ".",
            linkerSettings: [.linkedLibrary("wg-go")]
        ),
        .target(
            name: "WireGuardNetworkExtension",
            dependencies: ["WireGuardAppTunnel"],
            publicHeadersPath: "."
        )
    ]
)
