import SwiftUI

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



