import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            LearningHubView().tabItem { Label("Learn", systemImage: "book") }
            PromptAnalyzerView().tabItem { Label("Analyze", systemImage: "chart.bar.doc.horizontal") }
            AbstractionTrainerView().tabItem { Label("Abstraction", systemImage: "wand.and.stars") }
            TutorModeView().tabItem { Label("Tutor", systemImage: "message") }
            ProfileView().tabItem { Label("Profile", systemImage: "person") }
        }
    }
}
