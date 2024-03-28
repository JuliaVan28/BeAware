import SwiftUI

struct AlarmGameView: View {
    @EnvironmentObject var router: Router
    
    @State private var environments = EnvironmentViewModel.environments
    @State private var rulesCounter = 0
    @State private var envCounter = 0
    
    @State private var dropZone: CGRect?
    @State private var dropBoxText: String = ""
    @State private var dropBoxColor: Color = .clear
    
    @State var isIntermediateScreenPresented: Bool = false
    @State var isInstructionPresented: Bool = true
    
    @State var timer: Timer?
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                BackgroundView()
                    .scaleEffect(CGSize(width: geometry.size.width * 0.0015, height: geometry.size.height * 0.0013), anchor: .bottom)
                
                Rectangle()
                    .foregroundStyle(.black)
                    .opacity(0.2)
                
                VStack(spacing: geometry.size.height * 0.02){
                    
                    Spacer()
                    //MARK: - Home button
                    HomeButtonView(topPadding: geometry.size.height * 0.03, leadingPadding: geometry.size.height * 0.03)
                    
                    //MARK: Environments
                    HStack {
                        Spacer()
                        
                        Text("Environment:")
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                        Text(environments[envCounter].title)
                            .fontWeight(.bold)
                            .foregroundStyle(.yellow)
                        
                        Spacer()
                    }.font(.title2)
                        .padding(.horizontal, 10)
                        .background {
                            Rectangle()
                                .frame(width: geometry.size.width * 0.42, height: geometry.size.height * 0.06)
                                .foregroundStyle(.thinMaterial)
                                .preferredColorScheme(.dark)
                                .clipShape(.rect(cornerRadius: 30))
                        }
                    
                    //MARK: Rules
                    HStack {
                        Spacer()
                        
                        withAnimation(.snappy) {
                            Text(environments[envCounter].rules[rulesCounter].rule)
                                .font(.title)
                                .fontWeight(.semibold)
                                .lineLimit(4)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(Color.white)
                                .padding(.horizontal, 30)
                        }
                        
                        
                        Spacer()
                    }
                    .frame(height: geometry.size.height * 0.22)
                    .background {
                        RoundedRectangle(cornerRadius: 30.0,
                                         style: .continuous)
                        .foregroundStyle(Material.regular)
                        .opacity(1)
                        .blur(radius: 6)
                        .background {
                            Color.clear
                                .background(Color.yellow)
                                .environment(\.colorScheme, .dark)
                                .cornerRadius(30)
                                .opacity(0.1)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 30.0,
                                             style: .continuous)
                            .stroke( Color.yellow, lineWidth: 2)
                        )
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    
                    //MARK: Drop box
                    VStack {
                        
                        Rectangle()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.16)
                            .foregroundStyle(.regularMaterial)
                            .preferredColorScheme(.dark)
                            .overlay {
                                GeometryReader { geom in
                                    ZStack {
                                        dropBoxColor
                                        dropBoxText == "" ? Color.clear : Color.green.opacity(0.9)
                                        
                                        Text(dropBoxText)
                                            .font(.largeTitle)
                                            .padding()
                                    }
                                    .onAppear {
                                        let framGlob = geometry.frame(in: .global)
                                        let frameLocal = geom.frame(in: .local)
                                        dropZone = CGRect(x: framGlob.maxX / 2, y: framGlob.maxY - framGlob.maxY/6, width: frameLocal.width, height: frameLocal.height)
                                    }
                                }
                                
                            }
                            .clipShape(.rect(cornerRadius: 30))
                        
                        Text("Drag and drop emojis here 👆")
                            .font(.headline)
                    }
                    
                    // MARK: Emojis scroll
                    ZStack {
                        Color("darkBlue")
                            .opacity(0.8)
                            .blur(radius: 20.0)
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 20) {
                                ForEach(environments[envCounter].rules.shuffled()) { obj in
                                    
                                    Rectangle()
                                        .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.16)
                                        .foregroundStyle(.thinMaterial)
                                        .preferredColorScheme(.dark)
                                        .clipShape(.rect(cornerRadius: 30))
                                        .overlay {
                                            obj
                                                .padding(20)
                                        }
                                }
                            }
                        }
                        .padding()
                        .scrollIndicators(.hidden)
                    }
                    .frame(height: geometry.size.height * 0.2)
                    .opacity(environments[envCounter].rules.count == 1 && dropBoxText != "" ? 0 : 1)
                    
                    Spacer()
                    //MARK: - Next button
                    Button(action: {
                        withAnimation {
                            if envCounter < environments.count-1 {
                                envCounter += 1
                                dropBoxText = ""
                                dropBoxColor = .clear
                                
                            } else {
                                router.navigate(to: .alarmOutro)
                                
                            }
                        }
                    }) {
                        Text("Next")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.yellow)
                    }.opacity(environments[envCounter].rules.count == 1 && dropBoxText != "" ? 1 : 0)
                        .buttonStyle(NeumorphicButtonStyle(
                            isHighlighted: true,
                            width: geometry.size.width * 0.4))
                        .padding(.vertical, geometry.size.height * 0.02)
                    Spacer()
                    
                }
            }.ignoresSafeArea(.all)
        }
        // MARK: Instruction Screen
        .sheet(isPresented: $isInstructionPresented) {
            GeometryReader { geometry in
                ZStack {
                    Color.clear.ignoresSafeArea()
                    VStack(spacing: 20) {
                        Spacer()
                        Text("Let's learn what to do during an air raid alarm! 🚨")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Match each rule with emojis that represent it\n by dragging and dropping them")
                            .multilineTextAlignment(.center)
                            .font(.title2)
                            .fontWeight(.medium)
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Image(systemName: "hand.draw")
                                .resizable()
                                .foregroundStyle(Color.yellow)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                                .opacity(0.8)
                            
                            Spacer()
                        }
                        Spacer()
                        Button( action: {
                            isInstructionPresented.toggle()
                        }) {
                            Text("Okay")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.yellow)
                        }.buttonStyle(NeumorphicButtonStyle(
                            width: geometry.size.width * 0.3))
                        .padding()
                        
                        Spacer()
                    }
                    .padding(.all, 20)
                    .preferredColorScheme(.dark)
                }.background(
                    Image("forest-background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .blur(radius: 15)
                        .overlay {
                            Color.black.opacity(0.7)
                                .blur(radius: 15)
                        }
                )
            }
        }
        .onAppear {
            for envIndex in environments.indices {
                for index in environments[envIndex].rules.indices {
                    environments[envIndex].rules[index].onEnded = objectDropped
                }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
    
    func objectDropped(location: CGPoint, objRule: String) -> DragState {
        if let dropZone = self.dropZone {
            
            if dropZone.contains(location) {
                
                if objRule == environments[envCounter].rules[rulesCounter].rule {
                    
                    dropBoxText = environments[envCounter].rules[rulesCounter].emojis
                    
                    dropBoxColor = .green
                    
                    environments[envCounter].rules[rulesCounter].emojis = ""
                    if environments[envCounter].rules.count > 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                environments[envCounter].rules.remove(at: rulesCounter)
                            }
                            
                            dropBoxText = ""
                            dropBoxColor = .clear
                        }
                    }
                    
                    return .correct
                } else {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    
                    dropBoxColor = .red
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.smooth) {
                            dropBoxColor = .clear
                        }
                    }
                    
                    return .incorrect
                }
            }
        }
        return .unknown
        
    }
}

#Preview {
    AlarmGameView()
}



