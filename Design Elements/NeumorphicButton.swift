import SwiftUI

struct NeumorphicButtonStyle: ButtonStyle {
    var isHighlighted: Bool = false
    var width: CGFloat = 400
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(25)
            .frame(width: width)
            .background(
                Group {
                    if configuration.isPressed {
                        Capsule()
                            .fill(LinearGradient(Color("darkBlue"), Color("lighterBlue")))
                            .overlay(Capsule().stroke(LinearGradient(Color("lighterBlue"), Color("darkBlue")), lineWidth: 4))
                            .shadow(color: Color("lighterBlue"), radius: 10, x: 5, y: 5)
                            .shadow(color: Color("darkBlue"), radius: 10, x: -5, y: -5)
                        
                    } else {
                        Capsule()
                            .fill(Color("darkBlue"))
                            .overlay(Capsule().stroke( Color.yellow, lineWidth: isHighlighted ? 4 : 0))
                            .shadow(color: Color.white.opacity(0.1), radius: 10, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.6), radius: 10, x: 10, y: 10)
                    }
                }
            )
    }
}




