import Foundation
import Combine

// MARK: - Roster

class RosterViewModel: ObservableObject {
    @Published var characters: [RosterCharacter] = []

    init() { load() }

    private func load() {
        guard
            let url = Bundle.main.url(forResource: "roster", withExtension: "json"),
            let raw = try? Data(contentsOf: url),
            let decoded = try? JSONDecoder().decode(Roster.self, from: raw)
        else { return }
        self.characters = decoded.characters
    }
}

// MARK: - Grouped display models

struct PunishGroup: Identifiable {
    let id: String
    let title: String
    let entries: [PunishEntry]
}

struct MeatySetupGroup: Identifiable {
    let id: String
    let afterMove: String
    let entries: [MeatySetup]
}

// MARK: - Matchup

class MatchupViewModel: ObservableObject {
    @Published var data: MatchupData?
    @Published var characterInfo: CharacterInfo?
    let character: RosterCharacter

    private static let categoryOrder = [
        "normal", "uniqueAttack", "sprintFollowup", "special", "super"
    ]
    private static let categoryTitles: [String: String] = [
        "normal": "NORMALS",
        "uniqueAttack": "UNIQUE ATTACKS",
        "sprintFollowup": "SPRINT FOLLOWUPS",
        "special": "SPECIALS",
        "super": "SUPERS"
    ]

    var punishGroups: [PunishGroup] {
        guard let data = data else { return [] }
        return Self.categoryOrder.compactMap { category in
            let entries = data.punishes.filter { $0.category == category }
            guard !entries.isEmpty else { return nil }
            let title = Self.categoryTitles[category] ?? category.uppercased()
            return PunishGroup(id: category, title: title, entries: entries)
        }
    }

    var meatySetupGroups: [MeatySetupGroup] {
        guard let data = data else { return [] }
        var groups: [MeatySetupGroup] = []
        var orderKeys: [String] = []
        var map: [String: [MeatySetup]] = [:]
        for setup in data.meatySetups {
            if map[setup.afterMove] == nil {
                orderKeys.append(setup.afterMove)
                map[setup.afterMove] = []
            }
            map[setup.afterMove]?.append(setup)
        }
        for key in orderKeys {
            if let entries = map[key] {
                groups.append(MeatySetupGroup(id: key, afterMove: key, entries: entries))
            }
        }
        return groups
    }

    init(character: RosterCharacter) {
        self.character = character
        load()
    }

    private func load() {
        // kimberly uses the original "matchup" filename; others use "matchup_<id>"
        let fileName = character.id == "kimberly" ? "matchup" : "matchup_\(character.id)"
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
           let raw = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode(MatchupData.self, from: raw) {
            self.data = decoded
        }

        if let url = Bundle.main.url(forResource: "character_info", withExtension: "json"),
           let raw = try? Data(contentsOf: url),
           let all = try? JSONDecoder().decode([String: CharacterInfo].self, from: raw) {
            self.characterInfo = all[character.id]
        }
    }
}
