import XCTest
@testable import App

final class AppTests: XCTestCase {
    func testAnalysisShape() async throws {
        let service = LLMService()
        let app = Application(.testing)
        defer { app.shutdown() }
        let req = Request(application: app, on: app.eventLoopGroup.next())
        let response = try await service.analyze(prompt: "Build a secure JWT login API with tests", on: req)
        XCTAssertGreaterThan(response.clarityScore, 0)
        XCTAssertFalse(response.optimizedPrompt.isEmpty)
    }
}
