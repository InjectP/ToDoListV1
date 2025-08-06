
import SwiftUI

@main
struct ToDoListV1App: App {
    @StateObject private var vm = ViewModel()

    var body: some Scene {
        WindowGroup {
            TodoListView()
                .wrappedInNavigation()
                .environmentObject(vm)
        }
    }
}
