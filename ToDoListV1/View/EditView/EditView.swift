import SwiftUI

struct EditView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @FocusState  var isFocused: Bool

    @State var title: String = ""
    @State var text: String = ""
    @State var isEdit: Bool = false
    @State var showAlert = false
    @State var characterLimit = 17

    var todo: Todo
    var idObject: Int

    init(todo: Todo, idObject: Int) {
        _title = State(initialValue: todo.titleOrId)
        _text = State(initialValue: todo.todo)
        self.todo = todo
        self.idObject = idObject
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            content
        }
        .onAppear {
            isFocused = true
        }
        .navigationBarItems(leading: navBackButton)
        .alert(isPresented: $showAlert, content: alertView)
        .onChange(of: [title, text]) { _ in
            isEdit = true
        }
    }
}

#Preview {
    EditView(todo: Todo(id: 0, todo: "", completed: false), idObject: 0)
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}
