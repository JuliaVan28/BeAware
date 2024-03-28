import SwiftUI


struct AlarmView: View {
    @EnvironmentObject var router: Router
    @State var stepCounter: Int = 0
    @State var textPositon: Int = 0
    @State var speechText = SpeechTextViewModel.alarm
    
    @State var isIntermediateScreenPresented: Bool = false
    
    @State var animateOllie = false
    
    @State var isMom: Bool = false
    
    @State var timer: Timer?
    
    @State var isPlaying: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                BackgroundView()
                    .scaleEffect(CGSize(width: geometry.size.width * 0.0015, height: geometry.size.height * 0.0013), anchor: .bottom)
                
                VStack(spacing: geometry.size.height * 0.02) {
                    
                    //MARK: - Home button
                    HomeButtonView(topPadding: geometry.size.height * 0.06, leadingPadding: geometry.size.height * 0.03)
                    
                    //MARK: - Speech box
                    VStack {
                        HStack {
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 30.0,
                                             style: .continuous)
                            .foregroundStyle(isMom ? Color.yellow : Color("superDarkBlue"))
                            
                            .frame(width: geometry.size.width * 0.6,
                                   height: geometry.size.height * calculateFieldHeightCoeficient(phrase: speechText[stepCounter]))
                            .opacity(0.7)
                            .background {
                                Color.clear
                                    .background(.ultraThinMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .cornerRadius(30)
                            }
                            .overlay {
                                withAnimation {
                                    TypewriterTextView(text: $speechText, phraseIndex: $stepCounter, position: $textPositon, textColor: isMom ? Color("superDarkBlue") : Color.white)
                                        .padding()
                                }
                            }
                            
                            
                            
                            if isMom {
                                Spacer()
                                    .frame(width: geometry.size.width * 0.33 )
                            } else {
                                Spacer()
                                    .frame(width: geometry.size.width * 0.1 )
                            }
                        }
                        .frame(height: isMom && stepCounter == 2 ?  geometry.size.height * 0.2 : geometry.size.height * 0.3)
                        if isMom && stepCounter == 2 {
                            
                            Button {
                                if isPlaying {
                                    stopSound()
                                    isPlaying = false
                                } else {
                                    playSound(audioFileName: "alarm-air-raid-siren")
                                    isPlaying = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                        stopSound()
                                        isPlaying = false
                                    }
                                }
                            } label: {
                                Text(isPlaying ? "Stop ◼︎" : "Play ▶︎" )
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.yellow)
                                
                            }.buttonStyle(NeumorphicButtonStyle(isHighlighted: true, width: geometry.size.width * 0.28 ))
                                .frame(height: geometry.size.height * 0.09)
                        }
                    }
                    
                    //MARK: - Ollie and mom images
                    HStack {
                        Image("mama-bird-2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.38,
                                   height:  geometry.size.height * 0.42
                            )
                            .shadow(radius: 50)
                        
                        Image("ollie-bird")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.42,
                                   height:  geometry.size.height * 0.40
                            )
                            .shadow(radius: 50)
                            .offset(x: 250, y: -350)
                            .offset(x: self.animateOllie ? -250 : 0, y: self.animateOllie ? 400 : 0)
                    }.frame(height: geometry.size.height * 0.40)
                    
                    //MARK: - Next button
                    Button(action: {
                        withAnimation {
                            if stepCounter < speechText.count-1 {
                                
                                if textPositon < speechText[stepCounter].count-1 {
                                    
                                    //Interupt typewriting and set the whole phrase
                                    textPositon = speechText[stepCounter].count-1
                                    
                                } else {
                                    if stepCounter == 2 {
                                        stopSound()
                                        isPlaying = false
                                    }
                                    // Advance to next phrase
                                    textPositon = 0
                                    stepCounter += 1
                                }
                                //Show mom's text
                                if stepCounter == 1 || stepCounter == 2 || stepCounter == 4 {
                                    isMom = true
                                } else {
                                    isMom = false
                                }
                            } else {
                                // Show finish chapter screen
                                isIntermediateScreenPresented.toggle()
                                
                                timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) {_ in
                                    router.navigate(to: .raidRules)
                                }
                                
                            }
                        }
                    }) {
                        Text(stepCounter == speechText.count-1 ? "Finish Chapter" : "Next")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.yellow)
                    }.buttonStyle(NeumorphicButtonStyle(isHighlighted: true, width: geometry.size.width * 0.4))
                        .padding(.vertical, geometry.size.height * 0.03)
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden()
            }.ignoresSafeArea(.all)
                .overlay {
                    
                    ZStack {
                        Color.clear.ignoresSafeArea()
                        VStack(spacing: 0) {
                            Spacer()
                            Text("Up Next")
                                .font(.title2)
                            Text("Air Raid Rules")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            ZStack {
                                CircularCountDownView(isAnimated: $isIntermediateScreenPresented, duration: 5)
                                Text("▶︎")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.yellow)
                                
                            }.onTapGesture {
                                self.timer?.invalidate()
                                
                                router.navigate(to: .raidRules)
                            }
                            Spacer()
                        }.ignoresSafeArea()
                            .preferredColorScheme(.dark)
                    }.background(.regularMaterial)
                        .opacity(isIntermediateScreenPresented ? 1 : 0)
                }
            
            
        }.onAppear {
            withAnimation(.linear.speed(0.3)) {
                self.animateOllie.toggle()
            }
        }
    }
    
    
}

#Preview {
    AlarmView()
}
