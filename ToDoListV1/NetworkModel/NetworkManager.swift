
import Foundation

protocol NetworkModelProtocol {
    func fetchTodos() async throws -> TodoModel
}

final class NetworkManager: NetworkModelProtocol {

    static let shared = NetworkManager(); private init() {}
        
    private var server = "https://dummyjson.com/todos"
    
    func fetchTodos() async throws -> TodoModel {
        guard let url = URL(string: server) else { throw NetworkError.invalidUrl }
        let response = try await URLSession.shared.data(from: url)

        guard let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = try JSONDecoder().decode(TodoModel.self, from: response.0)
            return decoder
        } catch {
            throw error
        }
        
        
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case invalidUrl
}
