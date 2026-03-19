import SwiftUI

struct MeatySetupCard: View {
    let setup: MeatySetup

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            // Setup input
            VStack(alignment: .leading, spacing: 2) {
                Text("Setup:")
                    .font(.system(size: 11))
                    .foregroundColor(.secondaryText)
                Text(setup.setup)
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    .foregroundColor(.accent)
                    .fixedSize(horizontal: false, vertical: true)
            }

            // Beats
            if !setup.beats.isEmpty {
                OutcomeList(icon: "✅", items: setup.beats)
            }

            // Loses
            if !setup.loses.isEmpty {
                OutcomeList(icon: "❌", items: setup.loses)
            }

            // Trades
            if !setup.trades.isEmpty {
                OutcomeList(icon: "🔄", items: setup.trades)
            }

            // Notes
            if let notes = setup.notes {
                Text("📝 \(notes)")
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
}

// ── Shared outcome list ──────────────────────────────────────────────────────

struct OutcomeList: View {
    let icon: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: 5) {
                    Text(icon)
                        .font(.system(size: 12))
                    Text(item)
                        .font(.system(size: 12))
                        .foregroundColor(.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
