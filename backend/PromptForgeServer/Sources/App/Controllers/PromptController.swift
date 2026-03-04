import Vapor

struct PromptController {
    private let llm: LLMServiceProtocol = LLMService()

    func analyze(req: Request) async throws -> AnalysisResponse {
        let body = try req.content.decode(PromptRequest.self)
        return try await llm.analyze(prompt: body.prompt, on: req)
    }

    func reverseDebug(req: Request) async throws -> AnalysisResponse {
        let body = try req.content.decode(ReverseDebugRequest.self)
        return try await llm.reverseDebug(output: body.output, on: req)
    }

    func tutorReply(req: Request) async throws -> TutorMessageDTO {
        let body = try req.content.decode(TutorRequest.self)
        return TutorMessageDTO(id: UUID(), role: "assistant", content: "Try adding explicit output constraints for level \(body.level).")
    }
}
