
import SwiftUI

struct CircleButton: View {
    var width: CGFloat = 24
    var height: CGFloat = 24
    let completed: Bool
    let action: () -> Void
    var body: some View {
        Button{
            action()
        }label: {
            Image(systemName: completed ? "checkmark.circle" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(completed ? .yellow : .white.opacity(0.25))
        }
    }
}

#Preview {
    CircleButton(completed: true){}
}
