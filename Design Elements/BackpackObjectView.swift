import SwiftUI

struct BackpackObjectView: View, Identifiable {
    let id = UUID()
    
    @State private var dragOffset = CGSize.zero
    @State private var dragState = DragState.unknown
    
    var imageName: String
    var colorOverlay: String?
    var isInBackpack: Bool
    var objectExplanation: String
    
    var onEnded: ((CGPoint, String) -> DragState)?
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .offset(dragOffset)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        self.dragOffset = CGSize(width: $0.translation.width, height: $0.translation.height)
                    }
                    .onEnded {
                        //check if end location is backpack, and if object should be in backpack/
                        //if object should, add color to backpack and object disappears
                        //if object shouldn't - return to it's location
                        if self.onEnded?($0.location, self.imageName) != .correct
                        {
                            self.dragOffset = CGSize.zero
                        }
                    }
            )
            
    }
}

#Preview {
    BackpackObjectView(imageName: "bottle-water", isInBackpack: true, objectExplanation: "text")
}
