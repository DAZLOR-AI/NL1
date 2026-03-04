import Vapor

struct AbstractionController {
    private let llm: LLMServiceProtocol = LLMService()

    func transform(req: Request) async throws -> AbstractionResponse {
        let body = try req.content.decode(AbstractionRequest.self)
        return try await llm.transform(goal: body.goal, on: req)
    }
}
