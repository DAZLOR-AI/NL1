import Vapor

struct RegisterRequest: Content { let email: String; let password: String }
struct LoginRequest: Content { let email: String; let password: String }
struct PromptRequest: Content { let prompt: String }
struct ReverseDebugRequest: Content { let output: String }
struct AbstractionRequest: Content { let goal: String }
struct TutorRequest: Content { let messages: [TutorMessageDTO]; let level: String }
struct TutorMessageDTO: Content { let id: UUID?; let role: String; let content: String }
struct SubscriptionValidationRequest: Content { let originalTransactionId: String; let productId: String }

struct AnalysisResponse: Content {
    let clarityScore: Int
    let specificityScore: Int
    let determinismScore: Int
    let structureScore: Int
    let hallucinationRisk: Int
    let weaknesses: [String]
    let optimizedPrompt: String
    let reasoning: [String]
}

struct AbstractionResponse: Content {
    let intent: String
    let domainMap: [String: String]
    let technicalConstraints: [String]
    let outputSpecification: String
    let structuredPromptTemplate: String
    let optionalCode: String?
}
