import SwiftUI

func calculateFieldHeightCoeficient(phrase: String) -> CGFloat {
    let charCount = phrase.count
        switch charCount {
        case 0..<25:
            return 0.1
        case 25..<35:
            return 0.13
        case 35..<50:
            return 0.15
        case 50..<70:
            return 0.18
        case 70..<90:
            return 0.21
        case 90..<115:
            return 0.23
        case 115..<135:
            return 0.25
        default:
            return 0.27
        }
}
