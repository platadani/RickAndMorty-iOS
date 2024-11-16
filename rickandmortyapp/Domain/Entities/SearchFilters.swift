//
//  SearchFilters.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Observation

@Observable
class SearchFilters {
    var nameQuery: String
    var characterStatus: CharacterStatus?
    var characterGender: CharacterGender?

    init(nameQuery: String = "", characterStatus: CharacterStatus? = nil, characterGender: CharacterGender? = nil) {
        self.nameQuery = nameQuery
        self.characterStatus = characterStatus
        self.characterGender = characterGender
    }

    func setStatus(_ characterStatus: CharacterStatus) {
        if characterStatus == self.characterStatus {
            self.characterStatus = nil
        } else {
            self.characterStatus = characterStatus
        }
    }

    func setGender(_ characterGender: CharacterGender) {
        if characterGender == self.characterGender {
            self.characterGender = nil
        } else {
            self.characterGender = characterGender
        }
    }

    func toQueryParameters() -> [String: String] {
        var parameters: [String: String] = [:]
        if !nameQuery.isEmpty {
            parameters["name"] = nameQuery
        }
        if let status = characterStatus {
            parameters["status"] = status.rawValue
        }
        if let gender = characterGender {
            parameters["gender"] = gender.rawValue
        }
        return parameters
    }
}
