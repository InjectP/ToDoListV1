


import SwiftUI

extension View {
    func characterLimit(_ limit: Int, for binding: Binding<String>) -> some View {
        self.onChange(of: binding.wrappedValue) { newValue in
            if newValue.count > limit {
                binding.wrappedValue = String(newValue.prefix(limit))
            }
        }
    }
}
