import SwiftUI

extension Color {
    // Backgrounds
    static let appBackground   = Color(hex: "0A0C18")   // deep blue-black
    static let cardBackground  = Color(hex: "12152A")   // dark navy
    static let sectionHeader   = Color(hex: "0D1020")   // slightly darker navy
    static let cardBorder      = Color(hex: "2A2D4A")   // purple-tinted border

    // Brand
    static let sectionAccent   = Color(hex: "8B6CF7")   // violet — section headers & dividers
    static let accent          = Color(hex: "F5A623")   // orange — key values, combos

    // Text
    static let primaryText     = Color.white
    static let secondaryText   = Color(hex: "8A8FA8")   // blue-grey

    // Outcome
    static let beatsColor      = Color(hex: "36D97B")
    static let losesColor      = Color(hex: "FF4C4C")
    static let tradesColor     = Color(hex: "FFD60A")

    // Punish window tags
    static let tag4f           = Color(hex: "F5C542")   // yellow
    static let tag6f           = Color(hex: "F5A623")   // orange
    static let tag8fPlus       = Color(hex: "FF6B35")   // red-orange
    static let tagMassive      = Color(hex: "8B6CF7")   // violet

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
