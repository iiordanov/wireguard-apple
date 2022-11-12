
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
        .library(name: "WireGuardKit", targets: ["WireGuardKit", "WireGuardSharedLogging", "WireGuardSharedLoggingC", "WireGuardSharedModel", "WireGuardShared", "WireGuardNetworkExtension", "WireGuardApp"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WireGuardKit",
            dependencies: ["WireGuardKitC", "WireGuardKitGo"],
            path: "Sources/WireGuardKit"
        ),
        .target(
            name: "WireGuardSharedLoggingC",
            dependencies: [],
            path: "Sources/Shared/Logging",
            exclude: [
                "Logger.swift",
                "test_ringlogger.c"
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardSharedLogging",
            dependencies: ["WireGuardSharedLoggingC"],
            path: "Sources/Shared/Logging",
            exclude: [
                "ringlogger.c",
                "ringlogger.h",
                "test_ringlogger.c"
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardSharedModel",
            dependencies: ["WireGuardShared", "WireGuardKit", "WireGuardSharedLogging"],
            path: "Sources/Shared/Model",
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardShared",
            dependencies: ["WireGuardKit", "WireGuardSharedLogging"],
            path: "Sources/Shared",
            exclude: [
                "Logging",
                "Model"
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
            dependencies: ["WireGuardShared", "WireGuardSharedModel", "WireGuardSharedLogging"],
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardApp",
            dependencies: ["WireGuardKit", "WireGuardShared", "WireGuardSharedModel"],
            path: "Sources/WireGuardApp",
            exclude: [
                "Base.lproj",
                "Config",
                "Resources",
                "WireGuard-Bridging-Header.h",
                "UI/macOS",
                "UI/iOS/Assets.xcassets",
                "UI/iOS/Base.lproj",
                "ZipArchive",
                "ca.lproj",
                "de.lproj",
                "fa.lproj",
                "fi.lproj",
                "fr.lproj",
                "es.lproj",
                "id.lproj",
                "it.lproj",
                "ja.lproj",
                "ko.lproj",
                "pa.lproj",
                "pl.lproj",
                "ro.lproj",
                "ru.lproj",
                "sl.lproj",
                "tr.lproj",
                "zh-Hans.lproj",
                "zh-Hant.lproj"
            ],
            publicHeadersPath: "."
        )
    ]
)
