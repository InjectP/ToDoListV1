import SwiftUI
import CoreData

@MainActor
final class ViewModel: ObservableObject {
    @Published var todos: TodoModel?
    
    @Published var searchQuery: String = ""
    
    @Published var isDataLoaded: Bool = false
    
    @Published var todoIsLoaded: Bool = false
    { didSet {UserDefaults.standard.set(todoIsLoaded, forKey: "firstTime")}}
    
    let networkModel: NetworkModelProtocol
    var errors: String? = nil
    
    init(networkModel: NetworkModelProtocol = NetworkManager.shared)  {
        self.networkModel = networkModel
        loadData()
        loadTodos()
    }
    
    var taskCount: UUID = UUID()
    
    
}



extension ViewModel {
    //MARK: Search
    var filteredTodos: [Todo] {
        guard let todos = todos?.todos else { return [] }
        return searchQuery.isEmpty
        ? todos
        : todos.filter { $0.titleOrId.localizedCaseInsensitiveContains(searchQuery) }
    }
    
    // load Bool userDef
    func loadData() {
        if let savedData = UserDefaults.standard.value(forKey: "firstTime") as? Bool {
            todoIsLoaded = savedData
        }
    }
    
    //MARK: LOAD FROM NETWORK
    private func loadDataFromNetwork() {
        Task { [weak self] in
            guard let self = self else { return }

            do {
                let data = try await networkModel.fetchTodos()
                self.todos = data
                self.todoIsLoaded = true

                if var todosArray = self.todos?.todos {
                    todosArray = todosArray.map { todo in
                        var updatedTodo = todo
                        if updatedTodo.date == nil {
                            updatedTodo.date = self.getFormattedDate()
                        }
                        return updatedTodo
                    }

                    self.todos?.todos = todosArray
                    self.todos?.total = todosArray.count

                    TodoCoreDataService.shared.saveOrUpdate(todos: todosArray)
                }
            } catch {
                self.errors = error.localizedDescription
            }
        }
    }
    
    // get formated Date  (String)
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        return formatter.string(from: Date())
    }
    
    
    //MARK: Network or core data
    func loadTodos() {
        if todoIsLoaded {
            loadDataFromCoreData()
        } else {
            loadDataFromNetwork()
        }
    }
    
    // update after action with checkmark
    func updateCompleted(id: Int) {
        guard let index = todos?.todos.firstIndex(where: { $0.id == id }) else { return }
        todos?.todos[index].completed.toggle()

        TodoCoreDataService.shared.updateCompleted(id: id, completed: todos?.todos[index].completed ?? false)
        updateTaskCount()
    }
    

    
    // make object todo
    func getObject(index: Int) -> Todo {
        if let selectedTodo = todos?.todos.first(where: { $0.id == index }) {
            return selectedTodo
        }
        return Todo(id: -1, todo: "Default Todo", completed: false, title: "Default Title")
    }
    
    // delete todo
    func deleteTodo(id: Int) {
        if let index = todos?.todos.firstIndex(where: { $0.id == id }) {
            todos?.todos.remove(at: index)

            TodoCoreDataService.shared.deleteTodo(withId: id)
            
            getAmountTask()
            updateTaskCount()
        }
    }
    
    // update todo
    func updateTodo(id: Int, newTitle: String, newText: String, dateEdited: String) {
        guard let index = todos?.todos.firstIndex(where: { $0.id == id }) else { return }

        todos?.todos[index].title = newTitle
        todos?.todos[index].todo = newText
        todos?.todos[index].date = dateEdited

        TodoCoreDataService.shared.updateTodo(id: id, newTitle: newTitle, newText: newText, dateEdited: dateEdited)

        updateTaskCount()
    }
    
    // find free index for todo ID
    func findNextAvailableId() -> Int {
        guard let todos = todos?.todos, !todos.isEmpty else {
            return 1
        }
        let allIds = todos.map { $0.id }
        var nextId = 1
        
        while allIds.contains(nextId) {
            nextId += 1
        }
//        print(nextId)
        return nextId
    }

    // add todo
    func addTodo(todo: Todo) {
        todos?.todos.append(todo)
        TodoCoreDataService.shared.saveOrUpdate(todos: todos?.todos ?? [])
        getAmountTask()
        updateTaskCount()
        todoIsLoaded = true
    }
    
    // get amount task
    func getAmountTask() {
        if let todos = todos {
            self.todos?.total = todos.todos.count
        }
    }
    
    // update Total Count
    func updateTaskCount() {
        taskCount = UUID()
    }
    
    // MARK: Load from core data
    private func loadDataFromCoreData() {
        let todosArray = TodoCoreDataService.shared.fetchAllTodos()
        self.todos = TodoModel(todos: todosArray, total: todosArray.count)
        self.isDataLoaded = true
    }
    
}
