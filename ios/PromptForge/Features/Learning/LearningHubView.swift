import SwiftUI

struct LearningHubView: View {
    @StateObject private var vm: LearningViewModel

    init() {
        let client = APIClient(baseURL: URL(string: "https://api.promptforge.app")!, tokenProvider: { nil })
        _vm = StateObject(wrappedValue: LearningViewModel(lessonManager: LessonManager(apiClient: client)))
    }

    var body: some View {
        NavigationStack {
            List(vm.lessons) { lesson in
                VStack(alignment: .leading, spacing: 8) {
                    Text(lesson.title).font(.headline)
                    Text(lesson.scenario).font(.subheadline).foregroundStyle(.secondary)
                    Text("Weak: \(lesson.weakPrompt)").lineLimit(2)
                }
            }
            .overlay { if vm.isLoading { ProgressView() } }
            .navigationTitle("Use-Case Lessons")
            .onAppear { vm.loadLessons(for: .free) }
        }
    }
}
