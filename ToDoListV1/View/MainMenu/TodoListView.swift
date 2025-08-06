
import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var vm: ViewModel
    @State var selectedId: Int = 0
    @State var noteIsSelected: Bool = false
    @State var edit: Bool = false
    @State var newTodo: Todo?
    @State var showShareSheet = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Задачи")
                    .SFBold().hLeading().padding(.leading, 16)
                
                SearchBar(searchQuery: $vm.searchQuery)
                
                listTodo
                
                Spacer()
                bottomPanel
            }
            .opacity(vm.todos != nil ? 1 : 0)
            .blur(radius: noteIsSelected ? 5 : 0)
            .disabled(noteIsSelected)
            .ignoresSafeArea(edges: .bottom)
            
            selectedNote
            progressLoader
            
        }.navigationDestination(isPresented: $edit) {
            EditView(todo: vm.getObject(index: selectedId), idObject: selectedId).navigationBarBackButtonHidden()
                .onDisappear{
                    reset()
                }
        }
    }
}

#Preview {
    TodoListView()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}
