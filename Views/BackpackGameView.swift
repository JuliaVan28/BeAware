import SwiftUI


struct BackpackGameView: View {
    @EnvironmentObject var router: Router
    
    @State private var backpackObjects = BackpackObjectsViewModel.objects.shuffled()
    
    @State private var dropZone: CGRect?
    
    @State private var overlays: [String] = []
    
    @State private var itemsCounter: Int = 0
    
    @State private var degrees: Double = 0.0
    
    @State var isIntermediateScreenPresented: Bool = false
    @State var isInstructionPresented: Bool = true
    
    @State var showObjectExplanation: Bool = false
    @State var explanationText: String = "Ooops! We don't need this, let's take something else 👀"
    
    @State var timer: Timer?
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                BackgroundView()
                    .scaleEffect(CGSize(width: geometry.size.width * 0.0015, height: geometry.size.height * 0.0012), anchor: .bottom)
                
                Rectangle()
                    .foregroundStyle(Color("superDarkBlue"))
                    .opacity(0.4)
                
                Rectangle()
                    .foregroundStyle(.black)
                    .opacity(0.2)
                
                VStack(spacing: geometry.size.height * 0.017){
                    //MARK: - Home button
                    HomeButtonView(topPadding: geometry.size.height * 0.06, leadingPadding: geometry.size.height * 0.03)
                    //MARK: Items counter
                    HStack {
                        Spacer()
                        Text("Items:")
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                        Text("\(itemsCounter) / 7")
                            .fontWeight(.bold)
                            .foregroundStyle(.yellow)
                        
                        Spacer()
                    }.font(.title)
                        .background {
                            Rectangle()
                                .frame(width: geometry.size.width * 0.27, height: geometry.size.height * 0.06)
                                .foregroundStyle(.regularMaterial)
                                .preferredColorScheme(.dark)
                                .clipShape(.rect(cornerRadius: 30))
                        }
                    
                    //MARK: Backpack
                    withAnimation(.linear(duration: 1.0)) {
                        Image("backpack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .rotation3DEffect(Angle(degrees: degrees), axis: (x: 0, y: 360, z: 0))
                            .frame(width: geometry.size.width * 0.63,
                                   height:  geometry.size.height * 0.54)
                            .overlay {
                                ZStack {
                                    ForEach(overlays.indices, id: \.self) { index in
                                        Image(overlays[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                }
                                
                            }
                            .overlay {
                                //setting frame of drop zone for backpack objects
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            dropZone = geometry.frame(in: .local)
                                            print("configured dropZone")
                                            print(geometry.frame(in: .local))
                                            print(geometry.frame(in: .global))
                                        }
                                }
                            }
                        // MARK: Popover for backpack objects
                            .popover(isPresented: self.$showObjectExplanation,
                                     attachmentAnchor: .point(.bottom),
                                     arrowEdge: .top,
                                     content: {
                                Text(explanationText)
                                    .padding()
                            })
                        
                        
                    }
                    
                    
                    ZStack {
                        Color("darkBlue")
                            .opacity(0.8)
                            .blur(radius: 20.0)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(backpackObjects) { obj in
                                    ZStack {
                                        Rectangle()
                                            .frame(width: geometry.size.width * 0.32, height: geometry.size.height * 0.25)
                                            .foregroundStyle(.regularMaterial)
                                            .preferredColorScheme(.dark)
                                            .clipShape(.rect(cornerRadius: 30))
                                            .overlay {
                                                obj
                                                    .padding(30)
                                            }
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                        .scrollIndicators(.hidden)
                    }
                    
                }.navigationBarBackButtonHidden()
                
            }.ignoresSafeArea(.all)
            // MARK: Instruction Screen
                .sheet(isPresented: $isInstructionPresented) {
                    GeometryReader { geometry in
                        ZStack {
                            Color.clear.ignoresSafeArea()
                            VStack(spacing: 20) {
                                Spacer()
                                Text("Let's pack emergency backpack together! 🎒")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("Drag and drop items into the backpack")
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Text("Note that we don't need all of them, choose only the necessary ones! ")
                                    .multilineTextAlignment(.center)
                                    .font(.subheadline)
                                    .opacity(1)
                                    .fontWeight(.medium)
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image("ollie-bird")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.5)
                                        .shadow(radius: 50)
                                    
                                    
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
            // MARK: - Result Screen
                .overlay {
                    
                    ZStack {
                        Color.clear.ignoresSafeArea()
                        VStack(spacing: 0) {
                            Spacer()
                            ZStack {
                                CircularCountDownView(isAnimated: $isIntermediateScreenPresented, duration: 5)
                                Text("Menu")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.yellow)
                                
                            }.onTapGesture {
                                self.timer?.invalidate()
                                
                                router.navigateToRoot()
                            }
                            Spacer()
                        }
                    }.background(.regularMaterial)
                        .opacity(isIntermediateScreenPresented ? 1 : 0)
                }
        }.onAppear {
            for index in backpackObjects.indices {
                backpackObjects[index].onEnded = objectDropped
            }
        }
        .onChange(of: itemsCounter) { newVal in
            if itemsCounter == 7 {
                withAnimation {
                    degrees += 360
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showObjectExplanation = false
                    router.navigate(to: .outro)
                }
                
            }
        }
        
    }
    
    func objectDropped(location: CGPoint, objName: String) -> DragState {
        if let dropZone = self.dropZone {
            if dropZone.contains(location) {
                if let obj = backpackObjects.first(
                    where: {$0.imageName == objName}) {
                    
                    explanationText = obj.objectExplanation
                    
                    if obj.isInBackpack == true {
                        
                        backpackObjects.remove(at: backpackObjects.firstIndex(where: {$0.imageName == objName})!)
                        
                        if let color = obj.colorOverlay {
                            overlays.append("\(color)-ovrl")
                        }
                        
                        itemsCounter += 1
                        showObjectExplanation = true
                        
                        return .correct
                    } else {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        
                        showObjectExplanation = true
                        return .incorrect
                    }
                    
                    
                }
            }
        }
        return .unknown
        
    }
}

#Preview {
    BackpackGameView()
}
