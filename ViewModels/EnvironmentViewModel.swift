import SwiftUI

class EnvironmentViewModel: ObservableObject {
    static var environments: [EnvironmentModel] = [
        EnvironmentModel(title: "Outdoors", rules: [
            RulesObject(rule: "👉 Try to stay calm and\n follow instructions carefully.", emojis: "💆‍♂️💬👂🔊📝"),
            RulesObject(rule: "👉 Go to the closest shelter.\n It can be a metro station, underpass or underground parking lot.", emojis: "🏠➡️🚶‍♂️🚇🚧🚗🅿️"),
            RulesObject(rule: "👉 If you can't find a shelter, but see a forest or a park - hide there.", emojis: "🚫🏠❓🏞️🌲👀🙈")
        ],
                         backgroundImage: "outside image"),
        EnvironmentModel(title: "Home/Indoors", rules: [
            RulesObject(rule: "👉 Get dressed quickly and take the emergency backpack with you.", emojis: "👕👖👟🏃‍♂️🎒🚨"),
            RulesObject(rule: "👉 Stay away from windows.", emojis: "🚫🪟🏠👀"),
            RulesObject(rule: "👉 Go to the shelter with adults.", emojis: "👨‍👩‍👧‍👦🚶‍♂️🏠🚨"),
            RulesObject(rule: "👉 During evacuation, don't use the elevator, only go down with the stairs.", emojis: "🚫🛗🚶‍♂️👇🏽🏢👣"),
            RulesObject(rule: "👉 If there's no shelter nearby, follow the \"two-wall rule\": there should be at least 2 walls between you and the danger. Usually, this can be a hallway, corridor, or bathroom.", emojis: "🚫🏠❓2️⃣🧱🧱: 🛡️🧱🧱🚫💥🔥 ")
        ],
                         backgroundImage: "inside image"),
    ]
}
