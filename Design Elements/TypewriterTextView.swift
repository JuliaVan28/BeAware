// CREDITS: Thanks to Mobile Apps Academy for sharing this article that i used as a base for TypewriterTextView
// https://mobileappsacademy.medium.com/typewriter-animation-in-swiftui-49309b80b822

import SwiftUI

struct TypewriterTextView: View {
    
    @Binding var text: [String]
    @Binding var phraseIndex: Int
    @Binding  var position: Int
    
    var textColor: Color
    
    @State private var caption: String = ""
    @State private var phraseToType: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(caption)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(textColor)
            }
            Spacer()
        }
        .padding(30)
        .ignoresSafeArea()
        .onAppear() {
            phraseToType = text[0]
            typeWriter(at: 0, index: 0)
        }
        .onChange(of: phraseIndex, perform: { value in
            phraseToType = text[value]
            typeWriter(at: position, index: phraseIndex)
        })
    }
    
    
    
    func typeWriter(at pos: Int, index: Int) {
        position = pos
        if position == 0 {
            caption = ""
        }
        if position < text[index].count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                caption.append(phraseToType[phraseToType.index(phraseToType.startIndex, offsetBy: position)])
                typeWriter(at: position + 1, index: phraseIndex)
            }
        } else if position == text[index].count {
            caption = phraseToType
        }
    }
}

#Preview {
    TypewriterTextView(text: .constant(["Good news is, wars don't last forever."," They end when people decide to stop fighting and start talking. It takes courage and kindness to make peace, and I've seen the happiest days when that happens."]), phraseIndex: .constant(1), position: .constant(0), textColor: Color.white)
}

