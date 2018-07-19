import Vapor
import FluentSQLite
import Leaf

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    try services.register(FluentSQLiteProvider())

    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    // Configure the rest of your application here

    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)

    var database = DatabasesConfig()
    let sqlite = try SQLiteDatabase(storage: .memory)

    database.add(database: sqlite, as: .sqlite)
    services.register(database)

    var migrations = MigrationConfig()
    migrations.add(model: Message.self, database: .sqlite)
    services.register(migrations)

    //    let myService = NIOServerConfig.default(port: 8001)
    //    services.register(myService)
}
