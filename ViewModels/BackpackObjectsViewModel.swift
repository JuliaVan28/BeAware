import SwiftUI

class BackpackObjectsViewModel: ObservableObject {
    static var objects: [BackpackObjectView] = [
        BackpackObjectView(imageName: "bottle-water", colorOverlay: "blue", isInBackpack: true, objectExplanation: "Correct! Including a bottle of water is super important because it helps keep you hydrated"),
        BackpackObjectView(imageName: "snacks", colorOverlay: "yellow", isInBackpack: true, objectExplanation: "Nice, Snacks in your emergency backpack are important for keeping you energized and focused."),
        BackpackObjectView(imageName: "passport", colorOverlay: "green", isInBackpack: true, objectExplanation: "Having your ID is like a superhero cape - it keeps you safe in emergencies by showing who you are and where you belong."),
        BackpackObjectView(imageName: "phone-powerbank", colorOverlay: "pink", isInBackpack: true, objectExplanation: "A phone and powerbank are awesome because they keep you connected with family and let you call for help"),
        BackpackObjectView(imageName: "clothes", colorOverlay: "violet", isInBackpack: true, objectExplanation: "That's right! Don't forget to take a change of clothes, but don't take too much 👕"),
        BackpackObjectView(imageName: "brick", isInBackpack: false, objectExplanation: "We don't want to make our backpack too heavy, a brick is definitely too much 😄"),
        BackpackObjectView(imageName: "teddy-bear", colorOverlay: "red", isInBackpack: true, objectExplanation: "Great! Take your favorite to keep you company, bringing comfort and a little bit of joy when you need it most"),
        BackpackObjectView(imageName: "hammer", isInBackpack: false, objectExplanation: "Better leave hammer at home, we are not going to build anything"),
        BackpackObjectView(imageName: "sunglasses", isInBackpack: false, objectExplanation: "There will be no use for sunglasses in a shelter, so let's not take them with us"),
        BackpackObjectView(imageName: "shampoo", isInBackpack: false, objectExplanation: "That's a very big bottle of shampoo, try to take only small and necessary items"),
        BackpackObjectView(imageName: "paper", colorOverlay: "teal", isInBackpack: true, objectExplanation: "A note with your parent's contact info is super important. If you get lost, give it to adults for help.")
    ]
}
