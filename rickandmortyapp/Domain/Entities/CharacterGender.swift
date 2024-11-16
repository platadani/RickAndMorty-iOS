//
//  CharacterGender.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

enum CharacterGender: String, CaseIterable, Identifiable {
    static var filterCases = allCases.filter { $0 != .unknown }

    var id: String { self.rawValue }

    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown

    var textDescription: String {
        switch self {
            case .female: return String(localized: "female.title")
            case .male: return String(localized: "male.title")
            case .genderless: return String(localized: "genderless.title")
            case .unknown: return String(localized: "unknown.title")
        }
    }
}
