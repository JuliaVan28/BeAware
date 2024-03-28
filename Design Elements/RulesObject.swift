import SwiftUI

struct RulesObject: View, Identifiable {
    let id = UUID()
    
    var rule: String
    var emojis: String
    
    var onEnded: ((CGPoint, String) -> DragState)?
    
    @State private var dragOffset = CGSize.zero
    @State private var dragState = DragState.unknown
    
    var body: some View {
        Text(emojis)
            .font(.largeTitle)
            .offset(dragOffset)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        self.dragOffset = CGSize(width: $0.translation.width, height: $0.translation.height)
                    }
                    .onEnded {
                        if self.onEnded?($0.location, self.rule) != .correct
                        {
                            self.dragOffset = CGSize.zero
                        }
                    }
            )
            
    }
}

#Preview {
    RulesObject(rule: "test rule", emojis: "🏠➡️🚶‍♂️🚇🚧🚗🅿️")
}
