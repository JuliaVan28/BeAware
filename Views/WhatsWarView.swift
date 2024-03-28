import SwiftUI

struct WhatsWarView: View {
    @EnvironmentObject var router: Router
    @State var stepCounter: Int = 0
    @State var textPositon: Int = 0
    @State var speechText = SpeechTextViewModel.whatsWar
    
    @State var isIntermediateScreenPresented: Bool = false
    
    
    @State var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                BackgroundView()
                    .scaleEffect(CGSize(width: geometry.size.width * 0.0015, height: geometry.size.height * 0.0013), anchor: .bottom)
                
                VStack(spacing: geometry.size.height * 0.017) {
                    //MARK: - Home button
                    HomeButtonView(topPadding: geometry.size.height * 0.06, leadingPadding: geometry.size.height * 0.03)
                    
                    //MARK: - Speech box

                    HStack {
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 30.0,
                                         style: .continuous)
                        .foregroundStyle(Color("superDarkBlue"))
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
                                TypewriterTextView(text: $speechText, phraseIndex: $stepCounter, position: $textPositon, textColor: Color.white)
                                    .padding()
                            }
                        }
                        
                        Spacer()
                            .frame(width: geometry.size.width * 0.3)
                    }
                    .frame(height: geometry.size.height * 0.2)
                    
                    Spacer()
                    
                    //MARK: - Ollie image
                    
                    HStack {
                        
                        Spacer()
                        
                        Image("ollie-bird")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.5,
                                   height:  geometry.size.height * 0.5
                            )
                            .padding(.trailing, geometry.size.width * 0.05)
                            .shadow(radius: 50)
                    }
                    
                    //MARK: - Next button

                    Button(action: {
                        withAnimation {
                            if stepCounter < speechText.count - 1 {
                                
                                if textPositon < speechText[stepCounter].count - 1 {
                                    
                                    //Interupt typewriting and set the whole phrase
                                    textPositon = speechText[stepCounter].count - 1
                                    
                                } else {
                                    // Advance to next phrase
                                    textPositon = 0
                                    stepCounter += 1
                                }
                                
                            } else {
                                isIntermediateScreenPresented.toggle()
                                
                                timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) {_ in
                                    router.navigate(to: .alarm)
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
                            Text("Ollie Hears Air Raid Alarm")
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
                                
                                router.navigate(to: .alarm)
                            }
                                
                            Spacer()
                        }.ignoresSafeArea()
                        .preferredColorScheme(.dark)
                    }.background(.regularMaterial)
                        .opacity(isIntermediateScreenPresented ? 1 : 0)
                }
            
        }
    }
}

#Preview {
    WhatsWarView()
}
