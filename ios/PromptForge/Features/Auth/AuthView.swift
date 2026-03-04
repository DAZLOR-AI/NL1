import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 16) {
            Text("PromptForge")
                .font(.largeTitle.bold())
            Text("Learn structured prompting as an abstraction layer.")
                .foregroundStyle(.secondary)
            Button("Enter Demo") {
                appState.session = UserSession(userID: UUID(), email: "demo@promptforge.ai", jwt: "demo-token", tier: .free)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
