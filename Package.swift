// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WireGuardKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(name: "WireGuardKit", targets: ["WireGuardKit", "WireGuardSharedLoggingC", "WireGuardApp"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WireGuardKit",
            dependencies: ["WireGuardKitGo", "WireGuardKitC"]
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
            name: "WireGuardApp",
            dependencies: ["WireGuardKit", "WireGuardSharedLoggingC"],
            path: "Sources",
            exclude: [
                "Shared/Logging/ringlogger.c",
                "Shared/Logging/ringlogger.h",
                "Shared/Logging/test_ringlogger.c",
                "WireGuardKit",
                "WireGuardKitC",
                "WireGuardKitGo",
                "WireGuardApp/Base.lproj",
                "WireGuardApp/Config",
                "WireGuardApp/Resources",
                "WireGuardApp/UI/macOS",
                "WireGuardApp/UI/ActivateOnDemandViewModel.swift",
                "WireGuardApp/UI/TunnelViewModel.swift",
                "WireGuardApp/UI/TunnelImporter.swift",
                "WireGuardApp/UI/iOS/AppDelegate.swift",
                "WireGuardApp/UI/iOS/Assets.xcassets",
                "WireGuardApp/UI/iOS/Base.lproj",
                "WireGuardApp/UI/iOS/View",
                "WireGuardApp/UI/iOS/ViewController",
                "WireGuardApp/WireGuard-Bridging-Header.h",
                "WireGuardApp/ZipArchive",
                "WireGuardApp/ca.lproj",
                "WireGuardApp/de.lproj",
                "WireGuardApp/fa.lproj",
                "WireGuardApp/fi.lproj",
                "WireGuardApp/fr.lproj",
                "WireGuardApp/es.lproj",
                "WireGuardApp/id.lproj",
                "WireGuardApp/it.lproj",
                "WireGuardApp/ja.lproj",
                "WireGuardApp/ko.lproj",
                "WireGuardApp/pa.lproj",
                "WireGuardApp/pl.lproj",
                "WireGuardApp/ro.lproj",
                "WireGuardApp/ru.lproj",
                "WireGuardApp/sl.lproj",
                "WireGuardApp/tr.lproj",
                "WireGuardApp/zh-Hans.lproj",
                "WireGuardApp/zh-Hant.lproj"
            ],
            publicHeadersPath: "."
        )
    ]
)
