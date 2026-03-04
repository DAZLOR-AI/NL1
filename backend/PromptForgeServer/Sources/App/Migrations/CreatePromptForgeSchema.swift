import Fluent

struct CreatePromptForgeSchema: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("users").id().field("email", .string, .required).field("password_hash", .string, .required).field("tier", .string, .required).field("created_at", .datetime).unique(on: "email").create()
        try await database.schema("modules").id().field("name", .string, .required).field("tier", .string, .required).create()
        try await database.schema("lessons").id().field("module_id", .uuid, .required, .references("modules", "id")).field("title", .string, .required).field("scenario", .string, .required).field("weak_prompt", .string, .required).field("optimized_prompt", .string, .required).field("explanation", .string, .required).create()
        try await database.schema("prompt_attempts").id().field("user_id", .uuid, .required, .references("users", "id")).field("prompt", .string, .required).field("clarity", .int, .required).field("specificity", .int, .required).field("determinism", .int, .required).field("structure", .int, .required).field("hallucination_risk", .int, .required).field("created_at", .datetime).create()
        try await database.schema("user_progress").id().field("user_id", .uuid, .required, .references("users", "id")).field("lesson_id", .uuid, .required, .references("lessons", "id")).field("score", .int, .required).field("completed", .bool, .required).field("updated_at", .datetime).create()
        try await database.schema("subscriptions").id().field("user_id", .uuid, .required, .references("users", "id")).field("product_id", .string, .required).field("status", .string, .required).field("expires_at", .datetime).create()
        try await database.schema("usage_tracking").id().field("user_id", .uuid, .required, .references("users", "id")).field("day", .date, .required).field("optimizations_used", .int, .required).create()
    }

    func revert(on database: any Database) async throws {
        for table in ["usage_tracking", "subscriptions", "user_progress", "prompt_attempts", "lessons", "modules", "users"] {
            try await database.schema(table).delete()
        }
    }
}
