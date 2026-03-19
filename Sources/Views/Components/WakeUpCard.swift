import SwiftUI

struct WakeUpCard: View {
    let killer: WakeupSuperKiller

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title
            Text(killer.title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.accent)

            // After + KD advantage
            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .top, spacing: 4) {
                    Text("AFTER:")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondaryText)
                    Text(killer.afterMove)
                        .font(.system(size: 11))
                        .foregroundColor(.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let kd = killer.kdAdvantage {
                    Text("KD +\(kd)")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(.accent)
                }
            }

            // Setup
            VStack(alignment: .leading, spacing: 2) {
                Text("Setup:")
                    .font(.system(size: 11))
                    .foregroundColor(.secondaryText)
                Text(killer.setup)
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    .foregroundColor(.accent)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Rectangle()
                .fill(Color.cardBorder)
                .frame(height: 1)

            // Beats / Loses / Trades
            if !killer.beats.isEmpty {
                OutcomeList(icon: "✅", items: killer.beats)
            }
            if !killer.loses.isEmpty {
                OutcomeList(icon: "❌", items: killer.loses)
            }
            if !killer.trades.isEmpty {
                OutcomeList(icon: "🔄", items: killer.trades)
            }

            // Punish lines
            if let sa1 = killer.punishAfterBlockedSA1 {
                PunishLine(label: "Blocked SA1 punish:", combo: sa1)
            }
            if let sa3 = killer.punishAfterBlockedSA3 {
                PunishLine(label: "Blocked SA3 punish:", combo: sa3)
            }

            // Notes
            if let notes = killer.notes {
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

private struct PunishLine: View {
    let label: String
    let combo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(.secondaryText)
            Text(combo)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundColor(.accent)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
