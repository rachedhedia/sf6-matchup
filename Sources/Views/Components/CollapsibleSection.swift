import SwiftUI

struct CollapsibleSection<Content: View>: View {
    let title: String
    @Binding var isExpanded: Bool
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            // ── Header ──────────────────────────────────────
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 10) {
                    // Violet indicator bar
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.sectionAccent)
                        .frame(width: 3, height: 18)

                    Text(title)
                        .font(.system(size: 13, weight: .bold))
                        .tracking(1.5)
                        .foregroundColor(.primaryText)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.sectionAccent)
                        .font(.system(size: 11, weight: .semibold))
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                .padding(.leading, 13)
                .padding(.trailing, 16)
                .padding(.vertical, 14)
                .background(Color.sectionHeader)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Rectangle()
                .fill(Color.sectionAccent.opacity(0.35))
                .frame(height: 1)

            if isExpanded {
                content()
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}
