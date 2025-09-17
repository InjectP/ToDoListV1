import SwiftUI

struct NavigationWrapped: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack {
            content
                .navigationBarTitleDisplayMode(.large)

        }
        
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension View {
    func wrappedInNavigation() -> some View {
        self.modifier(NavigationWrapped()).tint(.yellow)
        
    }
}
