import SwiftUI

struct WakeUpKillersView: View {
    @ObservedObject var viewModel: MatchupViewModel
    @Binding var isExpanded: Bool

    private var reversals: [OpponentReversal] {
        viewModel.data?.opponentReversals ?? []
    }

    private var killers: [WakeupSuperKiller] {
        viewModel.data?.wakeupSuperKillers ?? []
    }

    var body: some View {
        CollapsibleSection(title: "WAKE-UP SUPER KILLERS", isExpanded: $isExpanded) {
            VStack(spacing: 0) {
                // ── Reversal reference table ────────────────
                VStack(alignment: .leading, spacing: 8) {
                    Text("KIMBERLY'S REVERSALS")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(1.2)
                        .foregroundColor(.secondaryText)

                    ForEach(reversals) { reversal in
                        ReversalRow(reversal: reversal)
                    }

                    // SA1 throw invincibility warning
                    HStack(alignment: .top, spacing: 6) {
                        Text("⚠️")
                            .font(.system(size: 12))
                        Text("SA1 is THROW invincible (f1–10). Delayed throw does NOT beat it. Safe jump or deliberate block-bait only.")
                            .font(.system(size: 11))
                            .foregroundColor(.tradesColor)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(10)
                    .background(Color(hex: "2A1F00"))
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.tradesColor.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 14)

                Rectangle()
                    .fill(Color.cardBorder)
                    .frame(height: 1)

                // ── Setup cards ─────────────────────────────
                VStack(spacing: 8) {
                    ForEach(killers) { killer in
                        WakeUpCard(killer: killer)
                    }
                }
                .padding(16)
            }
        }
    }
}

// ── Reversal reference row ───────────────────────────────────────────────────

struct ReversalRow: View {
    let reversal: OpponentReversal

    private var onBlockText: String {
        guard let ob = reversal.onBlock else { return "—" }
        return ob < 0 ? "\(ob)" : "+\(ob)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(reversal.name)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.primaryText)
                Spacer()
                if reversal.onBlock != nil {
                    Text(onBlockText)
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(.losesColor)
                }
            }
            Text(reversal.invincibility)
                .font(.system(size: 11))
                .foregroundColor(.secondaryText)
            Text("⚠️ \(reversal.warning)")
                .font(.system(size: 10))
                .foregroundColor(Color(hex: "FF9500"))
        }
        .padding(10)
        .background(Color.cardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.sectionAccent.opacity(0.25), lineWidth: 1)
        )
        .cornerRadius(10)
    }
}
