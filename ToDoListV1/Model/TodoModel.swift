
import Foundation

struct TodoModel: Codable, Hashable {
    var todos: [Todo]
    var total: Int
}

struct Todo: Codable, Hashable {
    var id: Int
    var todo: String
    var completed: Bool
    var title: String?
    var date: String?
}
