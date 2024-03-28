import SwiftUI

final class SpeechTextViewModel: ObservableObject {
    static let whatsWar: [String] = [
        "Hello, I'm Ollie!👋",
        "Today, I want to share something from my heart – it's my story about war.",
        "Let's explore this together 🫂",
        "One day I woke up and my mom told me that war has started.",
        "But, what is a war? 🤔",
        "It's when groups, like countries, disagree so much that they start fighting instead of talking.",
        "I've seen this happen over things like land, beliefs, or fear. It's tough, and I wish they'd talked it out.",
        "Good news is, wars don't last forever! They end when people decide to stop fighting and start talking.",
        "It takes courage and kindness to make peace, and I've seen the happiest days when that happens.",
        "You know what? You can help make the world peaceful too!",
        "Being kind, listening, and solving disagreements calmly – that's how you make a big difference!🌟",
        "Let's promise to do our part, alright?"
    ]
    
    static let alarm: [String] = [
        "Mom, I just heard a loud, alarming sound, when I was flying in the forest",
        "Ohh, that sounds worrying, Ollie! It might have been the air raid alarm. During a war, that's the signal for danger nearby.",
        "Did it sound like this?",
        "Yes. What should we do when we hear a similar sound, mom?",
        "Let me show you ➡️"
    ]
    static let alarmOutro: [String] = [
        "Thank you, mommy! Now we know what to do during an air raid alarm 🚨",
        "That's good, Ollie!\nHave you packed your emergency backpack already?",
        "Ohh, no. I will pack it now!\nHey, friend, will you help me? 😊"
    ]
    
    static let outro: [String] = [
        "Thank you for helping me pack my emergency backpack!",
       "Now that you know what war is, what to do during an air raid alarm, and what to have in your emergency backpack, you're all set for staying safe🛡️",
       "With knowledge and bravery, we can handle anything that comes our way during wartime.\nLet's keep safety first and always look out for each other! 🤗"
    ]
}
