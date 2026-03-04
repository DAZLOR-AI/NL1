import Vapor
import Fluent

struct AuthController {
    func register(req: Request) async throws -> HTTPStatus {
        let body = try req.content.decode(RegisterRequest.self)
        let hash = try Bcrypt.hash(body.password)
        let user = User(email: body.email, passwordHash: hash)
        try await user.save(on: req.db)
        return .created
    }

    func login(req: Request) async throws -> [String: String] {
        let body = try req.content.decode(LoginRequest.self)
        guard let user = try await User.query(on: req.db).filter(\.$email == body.email).first(),
              try Bcrypt.verify(body.password, created: user.passwordHash),
              let userID = user.id else { throw Abort(.unauthorized) }

        let token = try req.jwt.sign(UserToken(sub: .init(value: userID.uuidString), exp: .init(value: .distantFuture)))
        return ["token": token, "tier": user.tier]
    }

    func me(req: Request) async throws -> User {
        guard let token = req.auth.get(UserToken.self), let userID = UUID(uuidString: token.sub.value),
              let user = try await User.find(userID, on: req.db) else { throw Abort(.unauthorized) }
        return user
    }
}
