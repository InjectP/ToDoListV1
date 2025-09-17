
import SwiftUI
import CoreData

final class TodoCoreDataService {
    static let shared = TodoCoreDataService()
    private init() {}

    private let context = PersistenceController.shared.container.viewContext

    func saveOrUpdate(todos: [Todo]) {
        for (index, todo) in todos.enumerated() {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", todo.id)
            let entity: TodoEntity

            if let existing = try? context.fetch(request).first {
                entity = existing
            } else {
                entity = TodoEntity(context: context)
                entity.id = Int32(todo.id)
            }

            entity.todo = todo.todo
            entity.completed = todo.completed
            entity.title = todo.titleOrId
            entity.date = todo.date
            entity.order = Int32(index)
        }

        do {
            try context.save()
        } catch {
        }
    }

    func fetchAllTodos() -> [Todo] {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        do {
            return try context.fetch(request).map { entity in
                Todo(
                    id: Int(entity.id),
                    todo: entity.todo ?? "",
                    completed: entity.completed,
                    title: entity.title ?? "",
                    date: entity.date ?? ""
                )
            }
        } catch {
          
            return []
        }
    }

    func deleteTodo(withId id: Int) {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            if let entity = try context.fetch(request).first {
                context.delete(entity)
                try context.save()
            }
        } catch {
          
        }
    }

    func updateCompleted(id: Int, completed: Bool) {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            if let entity = try context.fetch(request).first {
                entity.completed = completed
                try context.save()
            }
        } catch {
          
        }
    }
    
    func updateTodo(id: Int, newTitle: String, newText: String, dateEdited: String) {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            if let entity = try context.fetch(request).first {
                entity.title = newTitle
                entity.todo = newText
                entity.date = dateEdited
                try context.save()
            }
        } catch {
        }
    }

}
