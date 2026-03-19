import SwiftUI

extension Color {
    // Backgrounds
    static let appBackground   = Color(hex: "0D0D0D")
    static let cardBackground  = Color(hex: "1C1C1E")
    static let sectionHeader   = Color(hex: "141414")
    static let cardBorder      = Color(hex: "2C2C2E")

    // Brand
    static let accent          = Color(hex: "F5A623")

    // Text
    static let primaryText     = Color.white
    static let secondaryText   = Color(hex: "8E8E93")

    // Outcome
    static let beatsColor      = Color(hex: "30D158")
    static let losesColor      = Color(hex: "FF453A")
    static let tradesColor     = Color(hex: "FFD60A")

    // Punish window tags
    static let tag4f           = Color(hex: "FFD60A")   // yellow
    static let tag6f           = Color(hex: "FF9500")   // orange
    static let tag8fPlus       = Color(hex: "FF3B30")   // red
    static let tagMassive      = Color(hex: "0A84FF")   // blue

    init(hex: String) {
        let s = Scanner(string: hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")))
        var rgb: UInt64 = 0
        s.scanHexInt64(&rgb)
        self.init(
            red:   Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >>  8) & 0xFF) / 255,
            blue:  Double( rgb        & 0xFF) / 255
        )
    }
}
