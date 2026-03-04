import Vapor
import JWT

struct UserToken: JWTPayload, Authenticatable {
    let sub: SubjectClaim
    let exp: ExpirationClaim

    func verify(using signer: JWTSigner) throws {
        try exp.verifyNotExpired()
    }
}

struct UserTokenAuthenticator: AsyncBearerAuthenticator {
    func authenticate(bearer: BearerAuthorization, for request: Request) async throws {
        if let payload = try? request.jwt.verify(bearer.token, as: UserToken.self) {
            request.auth.login(payload)
        }
    }
}
