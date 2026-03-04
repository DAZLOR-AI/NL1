// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PromptForgeServer",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "Run", targets: ["Run"])],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.92.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.9.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.9.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "4.2.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "JWT", package: "jwt")
            ],
            path: "Sources/App"
        ),
        .executableTarget(name: "Run", dependencies: ["App"], path: "Sources/Run"),
        .testTarget(name: "AppTests", dependencies: ["App"], path: "Tests/AppTests")
    ]
)
