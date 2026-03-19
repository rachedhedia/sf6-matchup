import Foundation

struct RosterCharacter: Codable, Identifiable {
    let id: String
    let name: String
    let portraitURL: String?
    let hasData: Bool
}

struct Roster: Codable {
    let characters: [RosterCharacter]
}

struct MatchupInfo: Codable {
    let attacker: String
    let defender: String
    let patch: String
    let source: String
}

struct PunishEntry: Codable, Identifiable {
    let id: String
    let moveName: String
    let category: String
    let onBlock: Int
    let punishWindow: String
    let bestPunish: String
    let notes: String?
    let imageURL: String?
}

struct MeatySetup: Codable, Identifiable {
    let id: String
    let afterMove: String
    let kdAdvantage: Int?
    let setup: String
    let beats: [String]
    let loses: [String]
    let trades: [String]
    let notes: String?
}

struct WakeupSuperKiller: Codable, Identifiable {
    let id: String
    let title: String
    let afterMove: String
    let kdAdvantage: Int?
    let setup: String
    let beats: [String]
    let loses: [String]
    let trades: [String]
    let punishAfterBlockedSA1: String?
    let punishAfterBlockedSA3: String?
    let notes: String?
}

struct OpponentReversal: Codable, Identifiable {
    var id: String { name }
    let name: String
    let invincibility: String
    let onBlock: Int?
    let warning: String
}

struct MatchupData: Codable {
    let matchup: MatchupInfo
    let punishes: [PunishEntry]
    let meatySetups: [MeatySetup]
    let wakeupSuperKillers: [WakeupSuperKiller]
    let opponentReversals: [OpponentReversal]
}
