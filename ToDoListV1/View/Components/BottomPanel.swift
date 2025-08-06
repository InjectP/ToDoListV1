
import SwiftUI

struct BottomPanel: View {
    @EnvironmentObject private var vm: ViewModel
    var action: () -> Void
    var body: some View {
        Rectangle()
            .fill(.customGray)
            .frame(maxWidth: .infinity, maxHeight: 83)
            .overlay(
                ZStack(alignment: .center) {
                    Text(taskText(for: vm.todos?.total ?? 0))
                        .SFRegular(11)
                    HStack {
                        Spacer()
                        createTaskButton
                    }
                }
            )
    }
}

#Preview {
    BottomPanel(){}
        .withAutoPreviewEnvironment()
}


extension BottomPanel {
    private func taskText(for count: Int) -> String {
           let lastDigit = count % 10
           let lastTwoDigits = count % 100
           
           if lastDigit == 1 && lastTwoDigits != 11 {
               return "\(count) задача"
           } else if (lastDigit == 2 || lastDigit == 3 || lastDigit == 4) && !(lastTwoDigits >= 12 && lastTwoDigits <= 14) {
               return "\(count) задачи"
           } else {
               return "\(count) задач"
           }
       }
    
    private var createTaskButton: some View {
        Button {
            withAnimation {
                action()
            }
        }label: {
            Image(systemName: "square.and.pencil")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(.yellow)
                .padding(.trailing, 34)
        }
    }
}
