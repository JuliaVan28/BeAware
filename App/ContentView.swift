import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Image("forest-background")
                    .resizable()
                    .ignoresSafeArea(.all, edges: .all)

                VStack(spacing: geometry.size.height * 0.017) {
                    
                    Spacer()
                    HStack {
                        
                        Spacer()
                        
                        Image("logo")
                            .resizable()
                            .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.18)
                            .aspectRatio(contentMode: .fill)
                            .background(Color("superDarkBlue").opacity(0.8).blur(radius: 50.0)
                                .padding(.bottom, 20)
                            )
                        
                        Spacer()
                    }
                    Spacer()
                    
                    Button  {
                        router.navigate(to: .whatsWar)
                        
                    }label: {
                        Text("Start")
                    }.buttonStyle(NeumorphicButtonStyle(isHighlighted: true, width: geometry.size.width * 0.4))
                    
                    Button  {
                        router.navigate(to: .chapters)
                    }label: {
                        Text("Chapters")
                    }.buttonStyle(NeumorphicButtonStyle(width: geometry.size.width * 0.4))
                    
                    Spacer()
                        .frame(height: geometry.size.height * 0.05)
                    
                    ZStack {
                        
                        HStack {
                            
                            Spacer()
                            
                            Image("mama-bird")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.20)
                                .padding(.leading, geometry.size.width * 0.18)
                            
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Image("ollie-bird")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.28)
                                .padding(.trailing, geometry.size.width * 0.13)
                            
                            Spacer()
                        }
                    }.padding(.bottom, geometry.size.height * 0.04)
                    
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.yellow)
            }
        }.ignoresSafeArea()
    }
}
