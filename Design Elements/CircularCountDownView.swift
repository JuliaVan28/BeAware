import SwiftUI

struct CircularCountDownView: View {
    
    @Binding var isAnimated: Bool
    
    var duration: TimeInterval
    
    @State private var progress: Double = 0.0
    
    
    var body: some View {
        ZStack {
            Capsule()
                .stroke(lineWidth: 6.0)
                .opacity(0.3)
                .foregroundColor(.black)
                .frame(width: 100, height: 200)
                .rotationEffect(Angle(degrees: 270))
            
            Capsule()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 6.0,
                                           lineCap: .round, lineJoin: .round))
                .foregroundColor(.yellow)
                .frame(width: 100, height: 200)
                .rotationEffect(Angle(degrees: 270))
        }
        .animation(Animation.linear(duration: duration), value: progress)
        .onChange(of: isAnimated) { _ in
            progress = 1.0
        }
        Spacer()
    }
}

#Preview {
    CircularCountDownView(isAnimated: .constant(false), duration: 5)
}
