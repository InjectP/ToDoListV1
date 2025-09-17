import SwiftUI

struct TodoEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @FocusState var isFocused: Bool
    @StateObject var editVM: TodoEditViewModel
    
    init(todo: Todo, idObject: Int, vm: ViewModel) {
        _editVM = StateObject(wrappedValue: TodoEditViewModel(todo: todo, idObject: idObject, vm: vm))
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            content
        }
        .onAppear { isFocused = true }
        .navigationBarItems(leading: navBackButton)
        .alert(isPresented: $editVM.showAlert, content: alertView)
        .onChange(of: [editVM.title, editVM.text]) { _ in
            editVM.handleChange()
        }
    }
}

#Preview {
    TodoEditView(todo: Todo(id: 0, todo: "", completed: false), idObject: 0, vm: ViewModel())
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}
