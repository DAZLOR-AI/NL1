import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    @ID(key: .id) var id: UUID?
    @Field(key: "email") var email: String
    @Field(key: "password_hash") var passwordHash: String
    @Field(key: "tier") var tier: String
    @Timestamp(key: "created_at", on: .create) var createdAt: Date?

    init() {}
    init(id: UUID? = nil, email: String, passwordHash: String, tier: String = "free") {
        self.id = id; self.email = email; self.passwordHash = passwordHash; self.tier = tier
    }
}

final class Module: Model, Content {
    static let schema = "modules"
    @ID(key: .id) var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "tier") var tier: String
    init() {}
    init(id: UUID? = nil, name: String, tier: String) { self.id = id; self.name = name; self.tier = tier }
}

final class Lesson: Model, Content {
    static let schema = "lessons"
    @ID(key: .id) var id: UUID?
    @Field(key: "module_id") var moduleID: UUID
    @Field(key: "title") var title: String
    @Field(key: "scenario") var scenario: String
    @Field(key: "weak_prompt") var weakPrompt: String
    @Field(key: "optimized_prompt") var optimizedPrompt: String
    @Field(key: "explanation") var explanation: String
    init() {}
}

final class PromptAttempt: Model, Content {
    static let schema = "prompt_attempts"
    @ID(key: .id) var id: UUID?
    @Field(key: "user_id") var userID: UUID
    @Field(key: "prompt") var prompt: String
    @Field(key: "clarity") var clarity: Int
    @Field(key: "specificity") var specificity: Int
    @Field(key: "determinism") var determinism: Int
    @Field(key: "structure") var structure: Int
    @Field(key: "hallucination_risk") var hallucinationRisk: Int
    @Timestamp(key: "created_at", on: .create) var createdAt: Date?
    init() {}
}
