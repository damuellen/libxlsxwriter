// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Windows)
let library = "Zlib"
#else
let library = "z"
#endif

let package = Package(
    name: "libxlsxwriter",
    products: [
        .library(
            name: "libxlsxwriter",
            targets: ["libxlsxwriter"]),
    ],
    targets: [
        .target(
            name: "libxlsxwriter",
            path: ".",
            exclude: [
                "src/Makefile",
            ],
            sources: [
                "include",
                "src",
                "third_party/minizip/zip.c",
                "third_party/minizip/ioapi.c",
                "third_party/tmpfileplus/tmpfileplus.c",
                "third_party/md5/md5.c"
            ],
            publicHeadersPath: "include",
            cSettings: [
                .define("_CRT_DEPRECATE_TEXT", .when(platforms: [.windows])),
                .define("_CRT_SECURE_NO_DEPRECATE", .when(platforms: [.windows])),
                .define("_CRT_SECURE_NO_WARNINGS", .when(platforms: [.windows])),
            ],
            linkerSettings: [
                .linkedLibrary(library)
            ]),
        .testTarget(
            name: "libxlsxwritertests",
            dependencies: ["libxlsxwriter"],
            path: ".",
            sources: ["test/swift"],
            linkerSettings: [
                .linkedLibrary(library)
            ]
        )
    ]
)
