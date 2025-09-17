    import SwiftUI

    extension TodoListView {
        
        func reset() {
            selectedId = 0
            noteIsSelected = false
            edit = false
            newTodo = nil
        }

        private func deleteTodoAction(todo: Todo) {
            vm.deleteTodo(id: todo.id)
            withAnimation {
                noteIsSelected = false
            }
        }
        
        @ViewBuilder
        var selectedNote: some View {
            if noteIsSelected {
                let selectedTodo = vm.getObject(index: selectedId)
                
                VStack {
                    SelectedNote(isPopUp: $noteIsSelected, todo: selectedTodo)
                        .transition(.scale)
                    
                    CustomAlert { action in
                        switch action {
                        case .edit:
                            edit.toggle()
                        case .share:
                            showShareSheet.toggle()
                        case .delete:
                            deleteTodoAction(todo: selectedTodo)
                            vm.getAmountTask()
                            vm.updateTaskCount()
                        }
                    }
                    .sheet(isPresented: $showShareSheet) {
                        ShareSheet(items: [selectedTodo.titleOrId, selectedTodo.todo])
                            .onDisappear {
                                reset()
                            }
                    }
                }
                .padding(.top, 100)
            }
        }
        
        @ViewBuilder
        var progressLoader: some View {
            if vm.todos == nil {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
            }
        }

        var listTodo: some View {
            VStack {
                ScrollView {
                    ForEach(vm.filteredTodos, id: \.id) { todo in
                        NoteCard(note: todo)
                            .onTapGesture {
                                withAnimation(.bouncy(duration: 0.3)) {
                                    selectedId = todo.id
                                    noteIsSelected = true
                                }
                            }
                    }
                }
            }
        }

        var bottomPanel: some View {
            BottomPanel {
                let id = vm.findNextAvailableId()
                newTodo = Todo(id: id, todo: "Новая заметка", completed: false, title: "", date: vm.getFormattedDate())
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    edit = true
                }
            }
        }
    }
