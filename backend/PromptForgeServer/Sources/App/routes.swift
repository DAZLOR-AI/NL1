import Vapor

public func routes(_ app: Application) throws {
    let auth = AuthController()
    let lessons = LessonController()
    let prompt = PromptController()
    let abstraction = AbstractionController()
    let subscription = SubscriptionController()

    app.group("auth") { authGroup in
        authGroup.post("register", use: auth.register)
        authGroup.post("login", use: auth.login)
    }

    let protected = app.grouped(UserTokenAuthenticator())
    protected.group("users") { userGroup in
        userGroup.get("me", use: auth.me)
    }

    protected.get("lessons", use: lessons.list)
    protected.post("prompt", "analyze", use: prompt.analyze)
    protected.post("prompt", "reverse-debug", use: prompt.reverseDebug)
    protected.post("abstraction", "transform", use: abstraction.transform)
    protected.post("subscription", "validate", use: subscription.validate)
    protected.post("tutor", "reply", use: prompt.tutorReply)
}
