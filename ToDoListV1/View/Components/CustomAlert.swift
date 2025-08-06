import SwiftUI

struct CustomAlert: View {
    var onAction: (AlertAction) -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 254, height: 132)
                .cornerRadius(12)
                .overlay(
                    VStack(spacing: 10) {
                        ForEach(AlertAction.allCases, id: \.self) { action in
                            Button{
                                onAction(action)
                            }label: {
                                HStack{
                                    Text(action.rawValue)
                                    Spacer()
                                    Image(imageName(for: action))
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .padding(.trailing)
                                }
                            }
                            .foregroundStyle(action == .delete ? .red : .black)
                            .padding(.leading)
                            
                            if action != AlertAction.delete {
                                Divider()
                                    .frame(height: 0.3)
                            }
                        }
                    }
                )
        }
    }
}

extension CustomAlert {
    
    enum AlertAction: String, CaseIterable {
        case edit = "Редактировать"
        case share = "Поделиться"
        case delete = "Удалить"
    }
    
    private func imageName(for action: AlertAction) -> String {
        switch action {
        case .edit:
            return "edit"
        case .share:
            return "export"
        case .delete:
            return "trash"
        }
    }
    
}


struct CheckAlert: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            CustomAlert { action in
                switch action {
                case .edit:
                    print("Редактирование")
                case .share:
                    print("Поделиться")
                case .delete:
                    print("Удаление")
                }
            }
        }
    }
}

#Preview {
    CheckAlert()
}


