import Routing
import Vapor
import FluentSQLite

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.get("hello") { req in
        return "Hello, world!"
    }

    router.get("getPerson") { req in
        return Person(name: "john", age: 23)
    }

    router.get { req -> Future<View> in
        return Message.query(on: req).all().flatMap(to: View.self) { (messages) in
            let context = ["messages": messages]
            return try req.view().render("home", context)
        }
    }

    router.post("send") { (req) -> Future<Response> in
        let username: String = try req.content.syncGet(at: "username")
        let content: String = try req.content.syncGet(at: "content")

        let message = Message(id: nil, username: username, content: content)

        return message.save(on: req).map(to: Response.self) { message in
            print(message)
            return req.redirect(to: "/")
        }
    }

    router.get("list") { req -> Future<[Message]> in
        return Message.query(on: req).all()
    }
}

struct Person: Content {
    let name: String
    let age: Int
}

struct Message: Content, SQLiteUUIDModel, Migration {
    var id: UUID?
    let username: String
    let content: String
}
