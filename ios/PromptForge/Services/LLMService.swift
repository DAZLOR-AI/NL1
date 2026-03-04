import Foundation
import Combine

protocol LLMServiceProtocol {
    func analyzePrompt(_ prompt: String) -> AnyPublisher<PromptAnalysis, Error>
    func runAbstraction(goal: String) -> AnyPublisher<AbstractionResult, Error>
    func tutorReply(messages: [TutorMessage], level: SubscriptionTier) -> AnyPublisher<TutorMessage, Error>
    func reverseDebug(output: String) -> AnyPublisher<PromptAnalysis, Error>
}

final class LLMService: LLMServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func analyzePrompt(_ prompt: String) -> AnyPublisher<PromptAnalysis, Error> {
        let payload = ["prompt": prompt]
        return post(path: "prompt/analyze", payload: payload)
    }

    func runAbstraction(goal: String) -> AnyPublisher<AbstractionResult, Error> {
        let payload = ["goal": goal]
        return post(path: "abstraction/transform", payload: payload)
    }

    func tutorReply(messages: [TutorMessage], level: SubscriptionTier) -> AnyPublisher<TutorMessage, Error> {
        struct Request: Codable { let messages: [TutorMessage]; let level: String }
        let payload = Request(messages: messages, level: level.rawValue)
        return post(path: "tutor/reply", payload: payload)
    }

    func reverseDebug(output: String) -> AnyPublisher<PromptAnalysis, Error> {
        let payload = ["output": output]
        return post(path: "prompt/reverse-debug", payload: payload)
    }

    private func post<T: Decodable, P: Encodable>(path: String, payload: P) -> AnyPublisher<T, Error> {
        let body = try? JSONEncoder().encode(payload)
        return apiClient.request(Endpoint(path: path, method: "POST", body: body))
    }
}
