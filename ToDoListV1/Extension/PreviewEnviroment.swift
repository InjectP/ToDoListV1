
import SwiftUI

extension View {
    func withAutoPreviewEnvironment() -> some View {
        return self
            .environmentObject(ViewModel())
    }
}
