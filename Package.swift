
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
            name: "MinizipC",
            dependencies: [],
            path: "Sources/WireGuardApp/ZipArchive/3rdparty/minizip",
            publicHeadersPath: "."
        ),
        .target(
            name: "WireGuardApp",
            dependencies: ["WireGuardKit", "Shared", "MinizipC"],
            path: "Sources/WireGuardApp",
            exclude: [
                "Base.lproj",
                "Config",
                "Resources",
                "WireGuard-Bridging-Header.h",
                "UI/macOS",
                "UI/iOS/Assets.xcassets",
                "ZipArchive/3rdparty/minizip",
                "ca.lproj",
                "de.lproj",
                "es.lproj",
                "fa.lproj",
                "fi.lproj",
                "fr.lproj",
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
            dependencies: ["WireGuardApp"],
            publicHeadersPath: "."
        )
    ]
)
