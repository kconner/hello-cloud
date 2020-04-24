import Vapor

func routes(_ app: Application) throws {
    app.get("health-check") { req -> String in
        return "Health check OK"
    }
}
