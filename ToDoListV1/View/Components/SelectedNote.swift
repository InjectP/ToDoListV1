import SwiftUI

struct  SelectedNote: View {
    @Binding var isPopUp: Bool
    var todo: Todo
    
    var body: some View {
        ZStack {
            if isPopUp {
                VStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.customGray)
                        .frame(width: 320, height: 108)
                        .shadow(radius: 20)
                        .overlay(
                            HStack(alignment: .top, spacing: 10) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("\(todo.titleOrId)")
                                        .SFMedium()
                                        .strikethrough(todo.completed)
                                    Text(todo.todo)
                                        .SFRegular()
                                        .lineLimit(2)
                                    Text(todo.date ?? "None")
                                        .SFRegular()
                                }
                                Spacer()
                            }
                                .padding(.horizontal)
                            .padding(.vertical, 16)
                        )
                }
                .padding()
            }
        }
        .onTapGesture {
            withAnimation(.bouncy(duration: 0.3)){
                isPopUp = false
            }
        }
    }
}

#Preview {
    TodoListView(     )
        .withAutoPreviewEnvironment()
}
