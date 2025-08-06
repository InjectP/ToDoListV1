import SwiftUI

extension Text {
    func SFBold(_ size: CGFloat = 45, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .bold))
            .foregroundStyle(color)
    }
    
    func SFMedium(_ size: CGFloat = 16, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .medium))
            .foregroundStyle(color)
    }
    
    func SFRegular(_ size: CGFloat = 12, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .regular))
            .foregroundStyle(color)
    }
}

extension View {
    func SFBold(_ size: CGFloat = 45, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .bold))
            .foregroundStyle(color)
    }
    
    func SFMedium(_ size: CGFloat = 16, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .medium))
            .foregroundStyle(color)
    }
    
    func SFRegular(_ size: CGFloat = 12, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .regular))
            .foregroundStyle(color)
    }
}






