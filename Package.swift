// swift-tools-version:4.0
import PackageDescription


let package = Package(
    name: "OutlawSimd",
    products: [
        .library(name: "OutlawSimd", targets: ["OutlawSimd"])
    ],
    dependencies: [
        .package(url: "https://github.com/Molbie/Outlaw.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "OutlawSimd", dependencies: ["Outlaw"]),
        .testTarget(name: "OutlawSimdTests", dependencies: ["OutlawSimd"])
    ]
)
