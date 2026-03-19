# SF6 Matchup Ref — Deejay vs Kimberly (iOS)

Quick-reference iOS app. Single dark scrollable screen with three collapsible sections:
1. **Punish Guide** — all of Kimberly's punishable moves grouped by category
2. **Meaty Setups** — post-knockdown options grouped by knockdown source
3. **Wake-Up Super Killers** — setups that beat SA1/SA3 on wake-up

## Xcode Setup

### 1. Create a new project

- Open Xcode → **File → New → Project**
- Template: **App** (iOS)
- Product Name: `SF6Matchup`
- Bundle Identifier: your choice (e.g. `com.yourname.SF6Matchup`)
- Interface: **SwiftUI**
- Language: **Swift**
- Minimum Deployments: **iOS 16.0**

### 2. Replace generated files

Delete the generated `ContentView.swift` and `SF6MatchupApp.swift` (or replace their contents).

### 3. Add source files

Drag all files from `Sources/` into the Xcode project navigator, maintaining groups:

```
Sources/
  SF6MatchupApp.swift
  ContentView.swift
  Models/
    MatchupModels.swift
  ViewModels/
    MatchupViewModel.swift
  Utils/
    AppColors.swift
  Views/
    PunishGuideView.swift
    MeatySetupsView.swift
    WakeUpKillersView.swift
    Components/
      CollapsibleSection.swift
      PunishCard.swift
      MeatySetupCard.swift
      WakeUpCard.swift
```

When prompted, ensure **"Copy items if needed"** is checked and **"Add to target: SF6Matchup"** is selected.

### 4. Add the JSON data file

Drag `Resources/matchup.json` into the Xcode project.

When prompted:
- Check **"Copy items if needed"**
- Check **"Add to target: SF6Matchup"** — this adds it to the bundle

### 5. Run

Select a simulator (iPhone 15 or similar) and press **⌘R**.

## File Map

| File | Purpose |
|------|---------|
| `matchup.json` | All hardcoded frame data — edit here to update content |
| `MatchupModels.swift` | `Codable` structs for JSON decoding |
| `MatchupViewModel.swift` | Loads JSON, groups punishes and meaty setups |
| `AppColors.swift` | `Color` extensions — design tokens |
| `CollapsibleSection.swift` | Reusable collapsible section header |
| `PunishCard.swift` | Card + punish window pill for Punish Guide |
| `MeatySetupCard.swift` | Card for Meaty Setups |
| `WakeUpCard.swift` | Card for Wake-Up Super Killers |
| `PunishGuideView.swift` | Section 1 — grouped punish cards |
| `MeatySetupsView.swift` | Section 2 — grouped by knockdown source |
| `WakeUpKillersView.swift` | Section 3 — reversal table + setup cards |
| `ContentView.swift` | Root ScrollView, header, section layout |

## Updating Data

All content lives in `Resources/matchup.json`. The JSON structure matches the schema in the spec. To add a move, add an entry to `punishes`, `meatySetups`, or `wakeupSuperKillers`.

**Punish window values:** `"4f"`, `"6f"`, `"8f+"`, `"massive"` (case-insensitive in the app).

**Punish categories:** `"normal"`, `"uniqueAttack"`, `"sprintFollowup"`, `"special"`, `"super"`.
