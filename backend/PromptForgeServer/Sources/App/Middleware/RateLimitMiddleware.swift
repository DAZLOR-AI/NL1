import Vapor

final class RateLimitMiddleware: AsyncMiddleware {
    private let limit: Int
    private let windowSeconds: Int
    private var counters: [String: (count: Int, resetAt: Date)] = [:]

    init(limit: Int, windowSeconds: Int) {
        self.limit = limit
        self.windowSeconds = windowSeconds
    }

    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        let key = request.remoteAddress?.ipAddress ?? "unknown"
        let now = Date()
        let current = counters[key] ?? (0, now.addingTimeInterval(TimeInterval(windowSeconds)))
        let refreshed = now > current.resetAt ? (0, now.addingTimeInterval(TimeInterval(windowSeconds))) : current
        guard refreshed.count < limit else { throw Abort(.tooManyRequests) }
        counters[key] = (refreshed.count + 1, refreshed.resetAt)
        return try await next.respond(to: request)
    }
}
