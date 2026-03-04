import Vapor

struct AppleSubscriptionValidator {
    func validate(transactionId: String, productId: String) async throws -> Bool {
        // Placeholder for App Store Server API validation workflow.
        !transactionId.isEmpty && productId.hasPrefix("com.promptforge")
    }
}
