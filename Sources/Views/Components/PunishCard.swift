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

// ── Punishable move — carte complète ─────────────────────────────────────────

struct PunishCard: View {
    let entry: PunishEntry

    private var onBlockText: String {
        entry.onBlock < 0 ? "\(entry.onBlock)" : "+\(entry.onBlock)"
    }

    var body: some View {
        if entry.isPunishable {
            punishableCard
        } else {
            compactRow
        }
    }

    // Carte complète pour les moves punishables
    private var punishableCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 10) {
                // Image du mouvement (depuis URL)
                if let urlStr = entry.imageURL, let url = URL(string: urlStr) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let img):
                            img.resizable().scaledToFill()
                                .frame(width: 72, height: 72)
                                .clipped()
                                .cornerRadius(6)
                        default:
                            moveImagePlaceholder
                        }
                    }
                    .frame(width: 72, height: 72)
                } else {
                    moveImagePlaceholder
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading, spacing: 1) {
                            Text(entry.moveName)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.primaryText)
                            if let cmd = entry.command {
                                Text(cmd)
                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                    .foregroundColor(.sectionAccent)
                            }
                        }
                        Spacer()
                        Text(onBlockText)
                            .font(.system(size: 15, weight: .bold, design: .monospaced))
                            .foregroundColor(entry.onBlock <= -12 ? .losesColor : .tag6f)
                    }

                    frameDataRow

                    if let punish = entry.bestPunish {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Best punish:")
                                .font(.system(size: 11))
                                .foregroundColor(.secondaryText)
                            Text(punish)
                                .font(.system(size: 12, weight: .medium, design: .monospaced))
                                .foregroundColor(.accent)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    if let window = entry.punishWindow {
                        PunishWindowTag(window: window)
                    }
                }
            }

            if let notes = entry.notes, !notes.isEmpty {
                Text("⚠️ \(notes)")
                    .font(.system(size: 11))
                    .foregroundColor(.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .background(Color.cardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.losesColor.opacity(0.35), lineWidth: 1)
        )
        .cornerRadius(12)
    }

    // Ligne compacte pour les moves non-punishables
    private var compactRow: some View {
        HStack(spacing: 8) {
            // Petite image
            if let urlStr = entry.imageURL, let url = URL(string: urlStr) {
                AsyncImage(url: url) { phase in
                    if case .success(let img) = phase {
                        img.resizable().scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipped()
                            .cornerRadius(4)
                    } else {
                        Color.cardBackground.frame(width: 36, height: 36).cornerRadius(4)
                    }
                }
                .frame(width: 36, height: 36)
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(entry.moveName)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primaryText.opacity(0.75))
                    if let cmd = entry.command {
                        Text(cmd)
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(.sectionAccent.opacity(0.7))
                    }
                }
                frameDataRow
            }
            Spacer()
            Text(onBlockText)
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundColor(onBlockColor)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(Color.cardBackground.opacity(0.5))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.cardBorder.opacity(0.4), lineWidth: 1)
        )
        .cornerRadius(8)
    }

    private var moveImagePlaceholder: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.cardBackground)
            .frame(width: 72, height: 72)
            .overlay(
                Image(systemName: "figure.martial.arts")
                    .font(.system(size: 22))
                    .foregroundColor(.secondaryText.opacity(0.3))
            )
    }

    @ViewBuilder
    private var frameDataRow: some View {
        let parts: [(String, String)] = [
            entry.startup.map { ("S", $0) },
            entry.active.map  { ("A", $0) },
            entry.recovery.map{ ("R", $0) }
        ].compactMap { $0 }

        if !parts.isEmpty {
            HStack(spacing: 6) {
                ForEach(parts, id: \.0) { label, value in
                    HStack(spacing: 2) {
                        Text(label)
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.secondaryText)
                        Text(value)
                            .font(.system(size: 10, weight: .semibold, design: .monospaced))
                            .foregroundColor(.secondaryText)
                    }
                }
            }
        }
    }

    private var onBlockColor: Color {
        if entry.onBlock <= -12 { return .losesColor }
        if entry.onBlock < 0    { return .tag6f }
        if entry.onBlock == 0   { return .secondaryText }
        return .beatsColor
    }
}

private func loadBundledImage(_ filename: String) -> UIImage? {
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil,
                                    subdirectory: "MoveImages") else { return nil }
    return UIImage(contentsOfFile: url.path)
}
