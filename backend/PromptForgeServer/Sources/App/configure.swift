import Vapor
import Fluent
import FluentPostgresDriver
import JWT

public func configure(_ app: Application) throws {
    guard let dbURL = Environment.get("DATABASE_URL"), let postgresURL = URL(string: dbURL) else {
        fatalError("DATABASE_URL must be configured")
    }

    app.databases.use(.postgres(url: postgresURL), as: .psql)
    app.migrations.add(CreatePromptForgeSchema())

    let jwtSecret = Environment.get("JWT_SECRET") ?? "dev-secret"
    app.jwt.signers.use(.hs256(key: jwtSecret))

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(RateLimitMiddleware(limit: 100, windowSeconds: 60))

    try routes(app)
}
