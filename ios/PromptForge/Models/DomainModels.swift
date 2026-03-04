import Foundation

enum SubscriptionTier: String, Codable, CaseIterable {
    case free, pro, research
}

struct UserSession: Codable {
    let userID: UUID
    let email: String
    let jwt: String
    let tier: SubscriptionTier
}

struct Lesson: Identifiable, Codable {
    let id: UUID
    let tier: SubscriptionTier
    let title: String
    let scenario: String
    let weakPrompt: String
    let optimizedPrompt: String
    let explanation: String
}

struct PromptBreakdown: Codable {
    var role: String
    var context: String
    var instruction: String
    var constraints: [String]
    var outputFormat: String
    var examples: [String]
    var edgeCases: [String]
}

struct PromptAnalysis: Codable {
    let clarityScore: Int
    let specificityScore: Int
    let determinismScore: Int
    let structureScore: Int
    let hallucinationRisk: Int
    let weaknesses: [String]
    let optimizedPrompt: String
    let reasoning: [String]
}

struct AbstractionResult: Codable {
    let intent: String
    let domainMap: [String: String]
    let technicalConstraints: [String]
    let outputSpecification: String
    let structuredPromptTemplate: String
    let optionalCode: String?
}

struct TutorMessage: Identifiable, Codable {
    let id: UUID
    let role: String
    let content: String
    let createdAt: Date
}
