import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("forest-background")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .ignoresSafeArea(.all, edges: .all)
    }
}


#Preview {
    BackgroundView()
}
