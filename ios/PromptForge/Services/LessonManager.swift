import Foundation
import Combine

protocol LessonManagerProtocol {
    func fetchLessons(tier: SubscriptionTier) -> AnyPublisher<[Lesson], Error>
}

final class LessonManager: LessonManagerProtocol {
    private let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol) { self.apiClient = apiClient }

    func fetchLessons(tier: SubscriptionTier) -> AnyPublisher<[Lesson], Error> {
        apiClient.request(Endpoint(path: "lessons?tier=\(tier.rawValue)", method: "GET"))
    }
}
