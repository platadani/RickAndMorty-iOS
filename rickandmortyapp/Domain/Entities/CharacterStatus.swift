//
//  CharacterStatus.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

enum CharacterStatus: String, CaseIterable, Identifiable {
    static var filterCases = allCases.filter { $0 != .unknown }

    var id: String { self.rawValue }

    case alive = "Alive"
    case dead = "Dead"
    case unknown

    var textDescription: String {
        switch self {
            case .alive: return String(localized: "alive.title")
            case .dead: return String(localized: "dead.title")
            case .unknown: return String(localized: "unknown.title")
        }
    }
}
