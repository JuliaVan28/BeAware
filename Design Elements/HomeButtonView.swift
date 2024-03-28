import SwiftUI

struct HomeButtonView: View {
    @EnvironmentObject var router: Router

    let topPadding: CGFloat
    let leadingPadding: CGFloat
    
    var body: some View {
        HStack {
            Button {
                router.navigateToRoot()
            } label: {
                Image(systemName: "house")
                    .padding(.all, 20)
                    .foregroundStyle(Color.yellow)
                    .font(.system(size: 30))
                    .background(Material.regular)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.yellow, lineWidth: 4).opacity(0.6))
                    .clipShape(.rect(cornerRadius: 20))
            }.padding(.leading, leadingPadding)
                .padding(.top, topPadding)
            Spacer()
        }
    }
}

#Preview {
    HomeButtonView(topPadding: 30, leadingPadding: 30)
}
