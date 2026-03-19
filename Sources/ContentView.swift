import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MatchupViewModel

    @State private var punishExpanded  = true
    @State private var meatyExpanded   = true
    @State private var wakeupExpanded  = true

    init(character: RosterCharacter) {
        _viewModel = StateObject(wrappedValue: MatchupViewModel(character: character))
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: []) {
                    MatchupHeaderView(info: viewModel.data?.matchup)

                    PunishGuideView(viewModel: viewModel, isExpanded: $punishExpanded)

                    SectionDivider()

                    MeatySetupsView(viewModel: viewModel, isExpanded: $meatyExpanded)

                    SectionDivider()

                    WakeUpKillersView(viewModel: viewModel, isExpanded: $wakeupExpanded)

                    // Footer
                    if let source = viewModel.data?.matchup.source {
                        Text("Source: \(source)")
                            .font(.system(size: 10))
                            .foregroundColor(Color.secondaryText.opacity(0.5))
                            .padding(.vertical, 20)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

// ── Header ───────────────────────────────────────────────────────────────────

private struct MatchupHeaderView: View {
    let info: MatchupInfo?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Text("🎮")
                    .font(.system(size: 20))
                Text(info.map { "\($0.attacker) vs \($0.defender)" } ?? "Loading…")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primaryText)
            }

            HStack(spacing: 8) {
                if let patch = info?.patch {
                    Label("Patch \(patch)", systemImage: "calendar")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.accent.opacity(0.12))
                        .cornerRadius(4)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 14)
        .background(Color.appBackground)
    }
}

// ── Thin divider between top-level sections ──────────────────────────────────

private struct SectionDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.cardBorder.opacity(0.7))
            .frame(height: 4)
    }
}
