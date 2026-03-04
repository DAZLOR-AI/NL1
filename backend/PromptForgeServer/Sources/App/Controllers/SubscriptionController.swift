import Vapor

struct SubscriptionController {
    private let validator = AppleSubscriptionValidator()

    func validate(req: Request) async throws -> [String: Bool] {
        let body = try req.content.decode(SubscriptionValidationRequest.self)
        let isValid = try await validator.validate(transactionId: body.originalTransactionId, productId: body.productId)
        return ["valid": isValid]
    }
}
