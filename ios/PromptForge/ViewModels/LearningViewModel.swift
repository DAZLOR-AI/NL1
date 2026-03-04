import Foundation
import Combine

final class LearningViewModel: ObservableObject {
    @Published var lessons: [Lesson] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let lessonManager: LessonManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    init(lessonManager: LessonManagerProtocol) {
        self.lessonManager = lessonManager
    }

    func loadLessons(for tier: SubscriptionTier) {
        isLoading = true
        lessonManager.fetchLessons(tier: tier)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let err) = completion { self?.errorMessage = err.localizedDescription }
            } receiveValue: { [weak self] in
                self?.lessons = $0
            }
            .store(in: &cancellables)
    }
}
