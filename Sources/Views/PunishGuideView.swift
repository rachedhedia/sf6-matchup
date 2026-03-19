import SwiftUI

struct PunishGuideView: View {
    @ObservedObject var viewModel: MatchupViewModel
    @Binding var isExpanded: Bool

    var body: some View {
        CollapsibleSection(title: "PUNISH GUIDE", isExpanded: $isExpanded) {
            VStack(spacing: 0) {
                ForEach(viewModel.punishGroups) { group in
                    PunishGroupSection(group: group)
                }
            }
        }
    }
}

private struct PunishGroupSection: View {
    let group: PunishGroup

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Category subheader
            Text(group.title)
                .font(.system(size: 10, weight: .semibold))
                .tracking(1.2)
                .foregroundColor(.secondaryText)
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 7)

            VStack(spacing: 7) {
                ForEach(group.entries) { entry in
                    PunishCard(entry: entry)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}
