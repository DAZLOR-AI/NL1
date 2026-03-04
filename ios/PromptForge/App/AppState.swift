import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var session: UserSession?
    @Published var selectedTab: AppTab = .learn
    @Published var tokenUsage: Int = 0

    var isAuthenticated: Bool { session != nil }
}

enum AppTab: Hashable {
    case learn, analyzer, abstraction, tutor, profile
}
