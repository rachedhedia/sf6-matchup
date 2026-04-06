import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MatchupViewModel
    private let character: RosterCharacter

    @State private var punishExpanded  = true
    @State private var meatyExpanded   = true
    @State private var wakeupExpanded  = true

    init(character: RosterCharacter) {
        self.character = character
        _viewModel = StateObject(wrappedValue: MatchupViewModel(character: character))
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: []) {
                    CharacterHeroView(character: character, info: viewModel.data?.matchup)

                    if let charInfo = viewModel.characterInfo {
                        CharacterInfoView(info: charInfo)
                        SectionDivider()
                    }

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
        .navigationBarTitleDisplayMode(.inline)
    }
}

// ── Hero image header ─────────────────────────────────────────────────────────

private struct CharacterHeroView: View {
    let character: RosterCharacter
    let info: MatchupInfo?

    var body: some View {
        ZStack(alignment: .bottom) {
            // Character portrait
            Group {
                if let urlString = character.portraitURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFill()
                        default:
                            Color.cardBackground
                        }
                    }
                } else {
                    Color.cardBackground
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 260)
            .clipped()

            // Gradient fade to background
            LinearGradient(
                colors: [.clear, Color.appBackground.opacity(0.6), Color.appBackground],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 260)

            // Text overlay at bottom
            VStack(alignment: .leading, spacing: 6) {
                if let patch = info?.patch {
                    Text("PATCH \(patch)")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(1.2)
                        .foregroundColor(.sectionAccent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.sectionAccent.opacity(0.15))
                        .cornerRadius(4)
                }
                Text(info.map { "\($0.attacker) vs \($0.defender)" } ?? character.name)
                    .font(.system(size: 24, weight: .black))
                    .foregroundColor(.primaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(height: 260)
    }
}

// ── Character info panel ──────────────────────────────────────────────────────

private struct CharacterInfoView: View {
    let info: CharacterInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Archetype + HP row
            HStack(spacing: 10) {
                Label(info.archetype, systemImage: "gamecontroller.fill")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.sectionAccent)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(Color.sectionAccent.opacity(0.15))
                    .cornerRadius(6)

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.losesColor)
                    Text("\(info.health)")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(.primaryText)
                }
                .padding(.horizontal, 9)
                .padding(.vertical, 4)
                .background(Color.losesColor.opacity(0.12))
                .cornerRadius(6)
            }

            // Strengths
            VStack(alignment: .leading, spacing: 6) {
                Label("STRENGTHS", systemImage: "bolt.fill")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.2)
                    .foregroundColor(.beatsColor)

                ForEach(info.strengths, id: \.self) { item in
                    HStack(alignment: .top, spacing: 6) {
                        Text("✦")
                            .font(.system(size: 9))
                            .foregroundColor(.beatsColor)
                            .padding(.top, 2)
                        Text(item)
                            .font(.system(size: 12))
                            .foregroundColor(.primaryText.opacity(0.85))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }

            // Weaknesses
            VStack(alignment: .leading, spacing: 6) {
                Label("WEAKNESSES", systemImage: "exclamationmark.triangle.fill")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.2)
                    .foregroundColor(.losesColor)

                ForEach(info.weaknesses, id: \.self) { item in
                    HStack(alignment: .top, spacing: 6) {
                        Text("✦")
                            .font(.system(size: 9))
                            .foregroundColor(.losesColor)
                            .padding(.top, 2)
                        Text(item)
                            .font(.system(size: 12))
                            .foregroundColor(.primaryText.opacity(0.85))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding(16)
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
