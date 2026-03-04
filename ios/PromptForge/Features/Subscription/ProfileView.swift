import SwiftUI

struct ProfileView: View {
    @StateObject private var manager = SubscriptionManager()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 14) {
                Text("Subscription")
                    .font(.title2.bold())
                Text("Current tier: \(manager.currentTier.rawValue.capitalized)")
                Text("Free: 5 optimizations/day • Pro: Unlimited • Research: Advanced architecture tools")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Profile")
            .task { await manager.refreshEntitlements() }
        }
    }
}
