import SwiftUI

extension EditView {
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleField
            dateText
            editorField
            Spacer()
        }
        .padding(.top)
    }
    private var titleField: some View {
        HStack {
            ScrollView(.horizontal) {
                TextField("Заголовок", text: $title)
                    .SFBold(42)
                    .characterLimit(characterLimit, for: $title)
            }
            .padding(.leading)
        }
    }
    private var dateText: some View {
        Text(todo.date ?? "None")
            .SFRegular(12)
            .opacity(0.5)
            .padding(.leading, 18)
    }

    private var editorField: some View {
        TextEditor(text: $text)
            .scrollContentBackground(.hidden)
            .padding(.vertical, 8)
            .SFRegular(16)
            .padding(.horizontal, 13)
            .focused($isFocused)
    }

    var navBackButton: some View {
        Button(action: handleBackButton) {
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 17, height: 22)
                Text("Назад")
                    .font(.system(size: 17))
            }
        }
    }

    private func handleBackButton() {
        if isEdit {
            showAlert = true
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }

    func alertView() -> Alert {
        Alert(
            title: Text("Данные изменены"),
            message: Text("Данные были изменены. Сохранить изменения?"),
            primaryButton: .destructive(Text("Отменить")) {
                presentationMode.wrappedValue.dismiss()
            },
            secondaryButton: .default(Text("Да")) {
                saveChanges()
                presentationMode.wrappedValue.dismiss()
            }
        )
    }

    private func saveChanges() {
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
    }
}
