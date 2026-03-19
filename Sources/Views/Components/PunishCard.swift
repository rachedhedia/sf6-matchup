import SwiftUI

// ── Punish window pill ───────────────────────────────────────────────────────

struct PunishWindowTag: View {
    let window: String

    private var color: Color {
        switch window.lowercased() {
        case "4f":      return .tag4f
        case "6f":      return .tag6f
        case "8f+":     return .tag8fPlus
        case "massive": return .tagMassive
        default:        return .secondaryText
        }
    }

    private var label: String {
        window.lowercased() == "massive" ? "● MASSIVE" : "● \(window.uppercased())"
    }

    var body: some View {
        Text(label)
            .font(.system(size: 10, weight: .bold, design: .monospaced))
            .foregroundColor(.black)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color)
            .cornerRadius(4)
    }
}

// ── Punish card ──────────────────────────────────────────────────────────────

struct PunishCard: View {
    let entry: PunishEntry

    private var onBlockText: String {
        entry.onBlock < 0 ? "\(entry.onBlock)" : "+\(entry.onBlock)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 10) {
                // Move thumbnail (bundled image)
                if let filename = entry.imageURL,
                   let uiImage = UIImage(named: filename, in: .main, compatibleWith: nil)
                    ?? loadBundledImage(filename) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .cornerRadius(6)
                        .background(Color.black.opacity(0.3))
                } else {
                    movePlaceholder
                }

                // Move name + frame data + punish
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(entry.moveName)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primaryText)
                        Spacer()
                        Text(onBlockText)
                            .font(.system(size: 15, weight: .bold, design: .monospaced))
                            .foregroundColor(.losesColor)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Best punish:")
                            .font(.system(size: 11))
                            .foregroundColor(.secondaryText)
                        Text(entry.bestPunish)
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                            .foregroundColor(.accent)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    PunishWindowTag(window: entry.punishWindow)
                }
            }

            // Notes
            if let notes = entry.notes {
                Text("⚠️ \(notes)")
                    .font(.system(size: 11))
                    .foregroundColor(.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .background(Color.cardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.cardBorder, lineWidth: 1)
        )
        .cornerRadius(8)
    }

    private var movePlaceholder: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.black.opacity(0.3))
            .frame(width: 72, height: 72)
            .overlay(
                Image(systemName: "figure.martial.arts")
                    .font(.system(size: 22))
                    .foregroundColor(.secondaryText.opacity(0.4))
            )
    }
}

private func loadBundledImage(_ filename: String) -> UIImage? {
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil,
                                    subdirectory: "MoveImages") else { return nil }
    return UIImage(contentsOfFile: url.path)
}
