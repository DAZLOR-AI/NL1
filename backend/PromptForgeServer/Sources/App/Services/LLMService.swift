import Vapor

protocol LLMServiceProtocol {
    func analyze(prompt: String, on req: Request) async throws -> AnalysisResponse
    func reverseDebug(output: String, on req: Request) async throws -> AnalysisResponse
    func transform(goal: String, on req: Request) async throws -> AbstractionResponse
}

struct LLMService: LLMServiceProtocol {
    func analyze(prompt: String, on req: Request) async throws -> AnalysisResponse {
        let weakness = prompt.count < 80 ? ["Missing constraints", "Low role anchoring"] : ["Minor ambiguity"]
        return AnalysisResponse(
            clarityScore: min(100, max(30, prompt.count / 2)),
            specificityScore: 74,
            determinismScore: 71,
            structureScore: 76,
            hallucinationRisk: 35,
            weaknesses: weakness,
            optimizedPrompt: "Role: Senior backend engineer\\nContext: Build secure JWT login in Vapor...",
            reasoning: ["Added role anchoring", "Specified constraints", "Defined output schema"]
        )
    }

    func reverseDebug(output: String, on req: Request) async throws -> AnalysisResponse {
        try await analyze(prompt: "Inferred from output: \(output)", on: req)
    }

    func transform(goal: String, on req: Request) async throws -> AbstractionResponse {
        AbstractionResponse(
            intent: goal,
            domainMap: ["security": "JWT", "backend": "Vapor"],
            technicalConstraints: ["Use PostgreSQL", "Token expiry 15m"],
            outputSpecification: "Return architecture plan + code snippets",
            structuredPromptTemplate: "Role: Staff iOS + backend engineer...",
            optionalCode: "struct LoginDTO: Codable { let email: String; let password: String }"
        )
    }
}
