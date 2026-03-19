import SwiftUI

struct CharacterSelectView: View {
    @StateObject private var vm = RosterViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 8) {
                            Text("🎮")
                                .font(.system(size: 20))
                            Text("DEEJAY")
                                .font(.system(size: 26, weight: .black))
                                .foregroundColor(.accent)
                        }
                        Text("Select opponent")
                            .font(.system(size: 13))
                            .foregroundColor(.secondaryText)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 24)

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(vm.characters) { character in
                            CharacterCell(character: character)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Character cell

private struct CharacterCell: View {
    let character: RosterCharacter

    var body: some View {
        if character.hasData {
            NavigationLink(destination: ContentView(character: character)) {
                cellContent.opacity(1)
            }
            .buttonStyle(.plain)
        } else {
            cellContent
                .opacity(0.4)
                .overlay(
                    Text("SOON")
                        .font(.system(size: 8, weight: .black))
                        .tracking(0.8)
                        .foregroundColor(.accent)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(Color.appBackground.opacity(0.85))
                        .cornerRadius(3)
                        .padding(5),
                    alignment: .topTrailing
                )
        }
    }

    private var cellContent: some View {
        VStack(spacing: 6) {
            portrait
                .frame(width: 96, height: 130)   // render taller so head isn't centered-cropped
                .frame(height: 96, alignment: .top) // clip to top 96 pt, keeping the head
                .clipped()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.cardBorder, lineWidth: 1)
                )

            Text(character.name)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.primaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }

    @ViewBuilder
    private var portrait: some View {
        if let urlString = character.portraitURL, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure, .empty:
                    letterPlaceholder
                @unknown default:
                    letterPlaceholder
                }
            }
        } else {
            letterPlaceholder
        }
    }

    private var letterPlaceholder: some View {
        Color.cardBackground
            .overlay(
                Text(String(character.name.prefix(1)))
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.secondaryText.opacity(0.4))
            )
    }
}
