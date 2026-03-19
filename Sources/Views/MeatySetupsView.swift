import SwiftUI

struct MeatySetupsView: View {
    @ObservedObject var viewModel: MatchupViewModel
    @Binding var isExpanded: Bool

    var body: some View {
        CollapsibleSection(title: "MEATY SETUPS", isExpanded: $isExpanded) {
            VStack(spacing: 0) {
                ForEach(Array(viewModel.meatySetupGroups.enumerated()), id: \.element.id) { index, group in
                    KnockdownGroup(group: group)
                    if index < viewModel.meatySetupGroups.count - 1 {
                        Rectangle()
                            .fill(Color.cardBorder.opacity(0.5))
                            .frame(height: 1)
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
    }
}

private struct KnockdownGroup: View {
    let group: MeatySetupGroup

    private var kdAdvantage: Int? {
        group.entries.first?.kdAdvantage
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Knockdown source header
            VStack(alignment: .leading, spacing: 3) {
                Text("AFTER:")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(1.2)
                    .foregroundColor(.secondaryText)
                HStack(spacing: 8) {
                    Text(group.afterMove)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.primaryText)
                    if let kd = kdAdvantage {
                        Text("KD +\(kd)")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundColor(.accent)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(Color.accent.opacity(0.12))
                            .cornerRadius(4)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .padding(.bottom, 8)

            VStack(spacing: 7) {
                ForEach(group.entries) { setup in
                    MeatySetupCard(setup: setup)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}
