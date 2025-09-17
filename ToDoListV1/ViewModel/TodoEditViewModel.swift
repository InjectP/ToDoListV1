import SwiftUI

@MainActor
final class TodoEditViewModel: ObservableObject {
    @Published var title: String
    @Published var text: String
    @Published var isEdit: Bool = false
    @Published var showAlert: Bool = false
    @Published var characterLimit: Int = 17
    
    private(set) var todo: Todo
    private(set) var idObject: Int
    
    private var vm: ViewModel
    
    init(todo: Todo, idObject: Int, vm: ViewModel) {
        self.todo = todo
        self.idObject = idObject
        self.vm = vm
        self._title = Published(initialValue: todo.titleOrId)
        self._text = Published(initialValue: todo.todo)
    }
    
    func handleChange() {
        isEdit = true
    }
    
    func handleBackButton(dismiss: @escaping () -> Void) {
        if isEdit {
            showAlert = true
        } else {
            dismiss()
        }
    }
    
    func saveChanges(dismiss: @escaping () -> Void) {
        if idObject != 0 {
            vm.updateTodo(id: idObject, newTitle: title, newText: text, dateEdited: vm.getFormattedDate())
        } else {
            let newTodo = Todo(
                id: vm.findNextAvailableId(),
                todo: text,
                completed: false,
                title: title,
                date: vm.getFormattedDate()
            )
            vm.addTodo(todo: newTodo)
        }
        dismiss()
    }
    
    
}
