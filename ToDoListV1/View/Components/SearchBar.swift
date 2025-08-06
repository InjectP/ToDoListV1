

import SwiftUI

struct SearchBar: View {
    @Binding var searchQuery: String
    let placeholder: String = "Search"
    let textSize: CGFloat = 16
    var body: some View {
        TextField("", text: $searchQuery)
            .SFRegular(textSize)
            .padding(.horizontal, 8)
            .padding(.trailing, 20)
            .frame(height: 36)
            .background(Color.customGray)
            .cornerRadius(10)
            .overlay{
                Group {
                    if searchQuery.isEmpty {
                        HStack(spacing: 0){
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.white)
                            Text(placeholder)
                                .SFRegular(textSize)
                                .allowsHitTesting(false)
                            
                        }.opacity(0.7).hLeading()
                    }
                    
                    if !searchQuery.isEmpty {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white)
                            .onTapGesture{
                                searchQuery = ""
                            }.hTrailing()
                    }
                }.padding(.horizontal, 5)
                
            }
            .padding(.horizontal)
    }
}

#Preview {
    SearchBar(searchQuery: .constant(""))
}
