import SwiftUI

extension View {
    
  
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }

  
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    @ViewBuilder
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    
    @ViewBuilder
    func vTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func vBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    @ViewBuilder
    func vCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }
    
  
    @ViewBuilder
    func hLeadingTop() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    @ViewBuilder
    func hLeadingBottom() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }

    @ViewBuilder
    func hTrailingTop() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }

    @ViewBuilder
    func hTrailingBottom() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    @ViewBuilder
    func vTopLeading() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    @ViewBuilder
    func vTopTrailing() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }

    @ViewBuilder
    func vBottomLeading() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }

    @ViewBuilder
    func vBottomTrailing() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
}
