import Foundation
import StoreKit
import Combine

@MainActor
final class SubscriptionManager: ObservableObject {
    @Published var currentTier: SubscriptionTier = .free

    func refreshEntitlements() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                switch transaction.productID {
                case "com.promptforge.pro": currentTier = .pro
                case "com.promptforge.research": currentTier = .research
                default: break
                }
            }
        }
    }

    func purchase(product: Product) async throws {
        let result = try await product.purchase()
        if case .success(let verification) = result,
           case .verified = verification {
            await refreshEntitlements()
        }
    }
}
