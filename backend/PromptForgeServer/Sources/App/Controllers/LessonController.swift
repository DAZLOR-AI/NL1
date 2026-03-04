import Vapor
import Fluent

struct LessonController {
    func list(req: Request) async throws -> [Lesson] {
        let tier = req.query[String.self, at: "tier"] ?? "free"
        let moduleIDs = try await Module.query(on: req.db).filter(\.$tier ~~ ["free", tier]).all().compactMap(\.id)
        return try await Lesson.query(on: req.db).filter(\.$moduleID ~~ moduleIDs).all()
    }
}
