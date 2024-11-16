//
//  Characgter.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Foundation

struct RMCharacter: Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let species: String
    let subspecieType: String
    let image: URL?
    let lastKnownLocation: String
    let originLocation: String
    let episodes: [Int]

    var hasSubspecie: Bool {
        !subspecieType.isEmpty
    }

    init(id: Int, name: String, status: CharacterStatus, gender: CharacterGender, species: String, subspecieType: String, image: URL?, lastKnownLocation: String, originLocation: String, episodes: [Int]) {
            self.id = id
            self.name = name
            self.status = status
            self.gender = gender
            self.species = species
            self.subspecieType = subspecieType
            self.image = image
            self.lastKnownLocation = lastKnownLocation
            self.originLocation = originLocation
            self.episodes = episodes
    }

    init(from response: CharacterResponse) {
        id = response.id
        name = response.name
        status = CharacterStatus(rawValue: response.status) ?? .unknown
        gender = CharacterGender(rawValue: response.gender) ?? .unknown
        species = response.species
        subspecieType = response.type
        image = URL(string: response.image)
        lastKnownLocation = response.location.name
        originLocation = response.origin.name
        episodes = response.episode.compactMap { Int($0.split(separator: "/").last ?? "") }
    }
}

extension RMCharacter {
    static var mock: RMCharacter {
        return RMCharacter(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            gender: .male,
            species: "Human",
            subspecieType: "Human",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            lastKnownLocation: "Earth",
            originLocation: "Earth",
            episodes: [1,2,3,6,7,10,11, 20]
        )
    }

    static var mockArray: [RMCharacter] {
        return [
            RMCharacter(
                id: 1,
                name: "Rick Sanchez",
                status: .alive,
                gender: .male,
                species: "Human",
                subspecieType: "Human",
                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                lastKnownLocation: "Earth",
                originLocation: "Earth",
                episodes: [1,2,3,6,7,10,11]
            ),
            RMCharacter(
                id: 2,
                name: "Morty Smith",
                status: .alive,
                gender: .male,
                species: "Human",
                subspecieType: "Human",
                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
                lastKnownLocation: "Earth",
                originLocation: "Earth",
                episodes: [1,2,3,6,7,10,11]
            ),
            RMCharacter(
                id: 3,
                name: "Summer Smith",
                status: .alive,
                gender: .female,
                species: "Human",
                subspecieType: "Human",
                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg"),
                lastKnownLocation: "Earth",
                originLocation: "Earth",
                episodes: [1,2,3,6,7,10,11]
            )
        ]
    }
}
