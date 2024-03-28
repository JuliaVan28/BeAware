import SwiftUI

struct ChaptersView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                Image("forest-background")
                    .resizable()
                    .ignoresSafeArea(.all, edges: .all)
                
                //MARK: Chapters
                VStack(spacing: 15) {
                    Spacer()
                    Text("Chapters")
                        .font(.system(size: geometry.size.width * 0.06))
                        .fontWeight(.bold)
                        .foregroundStyle(.yellow)
                        .padding(30)
                        .padding(.bottom, 20)
                        .background(Color("superDarkBlue").opacity(0.8).blur(radius: 30.0))
                    Group {
                        Button {
                            router.navigate(to: .whatsWar)
                        } label: {
                            Text("What's war?")
                                .padding(.all, 30)
                        }
                        .frame(width: geometry.size.width * 0.5)
                        
                        Button {
                            router.navigate(to: .alarm)
                        } label: {
                            Text("Air Raid Alarm")
                                .padding(.all, 30)
                        }
                        .frame(width: geometry.size.width * 0.5)
                        
                        Button {
                            router.navigate(to: .raidRules)
                        } label: {
                            Text("Air Raid Rules Game")
                                .padding(.all, 30)
                        }
                        .frame(width: geometry.size.width * 0.5)
                        
                        
                        Button {
                            router.navigate(to: .backpackGame)
                        } label: {
                            Text("Emergency Backpack Game")
                                .padding(.all, 30)
                        }
                        .frame(width: geometry.size.width * 0.5)
                    }
                    
                    .font(.title)
                    .fontWeight(.bold)
                    .background(Color("darkBlue").blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/).shadow(color: Color.black.opacity(0.6), radius: 10, x: 10, y: 10))
                    .clipShape(.rect(cornerRadius: 20, style: .continuous))
                    .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    Button {
                        router.navigateBack()
                    } label: {
                        Text("Back")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.yellow)
                    }.buttonStyle(NeumorphicButtonStyle(isHighlighted: true))
                    Spacer()
                }.padding()
                
            }.navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ChaptersView()
}
