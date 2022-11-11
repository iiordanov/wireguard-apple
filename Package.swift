
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
            name: "WireguardSharedLoggingC",
            dependencies: [],
            path: "Sources/Shared/Logging",
            exclude: [
                "Logger.swift"
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireguardSharedLogging",
            dependencies: ["SharedLoggingC"],
            path: "Sources/Shared/Logging",
            exclude: [
                "ringlogger.c",
                "ringlogger.h",
                "test_ringlogger.c"
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireguardShared",
            dependencies: ["WireGuardKit", "SharedLogging"],
            path: "Sources/Shared",
            exclude: [
                "Logging"
            ],
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
            dependencies: ["WireguardShared"],
            publicHeadersPath: "."
        )
    ]
)
