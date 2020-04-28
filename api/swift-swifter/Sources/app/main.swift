import Swifter
import Dispatch
import Logging

LoggingSystem.bootstrap { label in
  var handler = StreamLogHandler.standardOutput(label: label)
  // TODO: Set log level from environment
  handler.logLevel = .info
  return handler
}

let logger = Logger(label: "hello-cloud.api")
let server = HttpServer()

server["/health-check"] = { request in
    logger.info("/health-check")
    return .ok(.text("Health check OK"))
}

let semaphore = DispatchSemaphore(value: 0)
do {
    let port: UInt16 = 80
    try server.start(port, forceIPv4: true)
    logger.info("Serving on port \(port).")
    semaphore.wait()
} catch {
    logger.error("Server start error: \(error)")
    semaphore.signal()
}
