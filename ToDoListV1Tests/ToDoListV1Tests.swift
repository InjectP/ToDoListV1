import XCTest
@testable import ToDoListV1

// MARK: - MOCK

class MockNetworkModel: NetworkModelProtocol {
    func fetchTodos() async throws -> TodoModel {
        let todos = [
            Todo(id: 1, todo: "Test Todo 1", completed: false, title: "Test Title 1", date: "01/01/2024"),
            Todo(id: 2, todo: "Test Todo 2", completed: true, title: "Test Title 2", date: "02/01/2024")
        ]
        return TodoModel(todos: todos, total: todos.count)
    }
}

// MARK: - TESTS
@MainActor
final class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!
    var mockNetworkModel: MockNetworkModel!

    override func setUpWithError() throws {
        mockNetworkModel = MockNetworkModel()
        viewModel = ViewModel(networkModel: mockNetworkModel)
        viewModel.todos = TodoModel(todos: [], total: 0)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // MARK: - LOAD DATA
    
    func testLoadDataFromNetwork() {
        let expectation = expectation(description: "Load Data from Network")

        Task {
            await MainActor.run {
                self.viewModel.todoIsLoaded = false
                self.viewModel.loadTodos()
            }

            try? await Task.sleep(nanoseconds: 300_000_000)

            await MainActor.run {
                let todos = self.viewModel.todos?.todos
                XCTAssertNotNil(todos)
                XCTAssertEqual(todos?.count, 2)
                XCTAssertEqual(todos?.first?.title, "Test Title 1")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - ADD
    
    func testAddTodo() {
        let todo = Todo(id: 1, todo: "Test Todo", completed: false, title: "Test Title", date: "01/01/2024")
        viewModel.addTodo(todo: todo)

        XCTAssertEqual(viewModel.todos?.todos.count, 1)
        XCTAssertEqual(viewModel.todos?.todos.first?.id, 1)
    }
    
    // MARK: - UPDATE
    
    func testUpdateTodo() {
        let todo = Todo(id: 10, todo: "Old Todo", completed: false, title: "Old Title", date: "01/01/2024")
        viewModel.addTodo(todo: todo)
        
        viewModel.updateTodo(
            id: 10,
            newTitle: "Updated Title",
            newText: "Updated Todo",
            dateEdited: "02/01/2024"
        )
        
        let updated = viewModel.todos?.todos.first(where: { $0.id == 10 })
        
        XCTAssertEqual(updated?.title, "Updated Title")
        XCTAssertEqual(updated?.todo, "Updated Todo")
        XCTAssertEqual(updated?.date, "02/01/2024")
    }
    
    // MARK: - DELETE
    
    func testDeleteTodo() {
        let todo = Todo(id: 100, todo: "Test Todo", completed: false, title: "Test Title", date: "01/01/2024")
        viewModel.addTodo(todo: todo)
        
        XCTAssertEqual(viewModel.todos?.todos.count, 1)

        viewModel.deleteTodo(id: 100)

        XCTAssertEqual(viewModel.todos?.todos.count, 0)
    }

    // MARK: - SEARCH

    func testSearchTodos() {
        let todo1 = Todo(id: 1, todo: "Do homework", completed: false, title: "Math", date: "01/01/2024")
        let todo2 = Todo(id: 2, todo: "Read book", completed: false, title: "Science", date: "01/01/2024")
        
        viewModel.addTodo(todo: todo1)
        viewModel.addTodo(todo: todo2)
        
        viewModel.searchQuery = "Math"
        
        XCTAssertEqual(viewModel.filteredTodos.count, 1)
        XCTAssertEqual(viewModel.filteredTodos.first?.id, 1)
    }

    // MARK: - ID FINDER
    
    func testFindNextAvailableId() {
        let todo1 = Todo(id: 1, todo: "A", completed: false, title: "A", date: "01/01/2024")
        let todo2 = Todo(id: 2, todo: "B", completed: false, title: "B", date: "01/01/2024")
        viewModel.addTodo(todo: todo1)
        viewModel.addTodo(todo: todo2)

        let nextId = viewModel.findNextAvailableId()
        XCTAssertEqual(nextId, 3)
    }

    // MARK: - Update Completed
    
    func testUpdateCompleted() {
        let todo = Todo(id: 5, todo: "Check this", completed: false, title: "Toggle Test", date: "01/01/2024")
        viewModel.addTodo(todo: todo)

        viewModel.updateCompleted(id: 5)

        let updated = viewModel.todos?.todos.first(where: { $0.id == 5 })
        XCTAssertEqual(updated?.completed, true)
    }
}
