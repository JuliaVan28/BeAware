import SwiftUI

@main
struct MyApp: App {
    
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {

            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .whatsWar:
                            WhatsWarView()
                        case .alarm:
                            AlarmView()
                        case .raidRules:
                            AlarmGameView()
                        case .alarmOutro:
                            AlarmOutroView()
                        case .backpackGame:
                            BackpackGameView()
                        case .outro:
                            OutroView()
                        case .chapters:
                            ChaptersView()
                        }
                    }
                    
            }.preferredColorScheme(.dark)
            .environmentObject(router)
        }
    }
}
