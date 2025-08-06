
import SwiftUI

struct NoteCard: View {
    @EnvironmentObject private var vm: ViewModel
    var note: Todo

    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: 10) {
                CircleButton(completed: note.completed) {
                    vm.updateCompleted(id: note.id)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(note.titleOrId)
                        .SFMedium()
                        .strikethrough(note.completed)
                    Text(note.todo)
                        .SFRegular()
                        .lineLimit(2)
                    Text(note.date ?? "None")
                        .SFRegular()
                }
                .opacity(note.completed ? 0.25 : 1)
           
                
            }.padding(.vertical, 16).hLeading().padding(.horizontal, 8)
            
            Divider()
                .frame(height: 0.4)
                .background(Color.white)
                .padding(.horizontal)
        }
    }
}



#Preview {
    ZStack {
        Color.black
        NoteCard(note: Todo(id: 0, todo: "Выдd", completed: false, title: "Почитать книгу", date: "0/9/9"))
            .withAutoPreviewEnvironment()
    }
}


extension Todo {
    var titleOrId: String {
        guard let strTitle = title else { return "Default \(id)"}
        return strTitle.isEmpty ? "" : strTitle
    }
}
