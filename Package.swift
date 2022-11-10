
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
        .library(name: "WireGuardKit", targets: ["WireGuardKit", "WireGuardNetworkExtension"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WireGuardKit",
            dependencies: ["WireGuardKitC", "WireGuardKitGo"],
            path: "Sources/WireGuardKit"
        ),
        .target(
            name: "SharedLoggingC",
            dependencies: [],
            path: "Sources/Shared/Logging",
            exclude: [
                "Logger.swift"
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "Shared",
            dependencies: ["SharedLoggingC", "WireGuardKit"],
            path: "Sources/Shared",
            exclude: [
                "Logging/ringlogger.h",
                "Logging/ringlogger.c",
                "Logging/test_ringlogger.c"
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardAppTunnel",
            dependencies: ["WireGuardKit", "Shared"],
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
