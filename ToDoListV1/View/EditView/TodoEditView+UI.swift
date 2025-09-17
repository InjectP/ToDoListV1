import SwiftUI

extension TodoEditView {
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
                TextField("Заголовок", text: $editVM.title)
                    .SFBold(42)
                    .characterLimit(editVM.characterLimit, for: $editVM.title)
            }
            .padding(.leading)
        }
    }
    
    private var dateText: some View {
        Text(editVM.todo.date ?? "None")
            .SFRegular(12)
            .opacity(0.5)
            .padding(.leading, 18)
    }
    
    private var editorField: some View {
        TextEditor(text: $editVM.text)
            .scrollContentBackground(.hidden)
            .padding(.vertical, 8)
            .SFRegular(16)
            .padding(.horizontal, 13)
            .focused($isFocused)
    }
    
    var navBackButton: some View {
        Button {
            editVM.handleBackButton {
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 17, height: 22)
                Text("Назад")
                    .font(.system(size: 17))
            }
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
                editVM.saveChanges {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
    }
}
