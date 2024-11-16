//
//  CharacterResponse.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

struct CharacterResponse: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationResponse
    let location: LocationResponse
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

extension CharacterResponse {
    static var mock: CharacterResponse {
        CharacterResponse(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationResponse(name: "Earth", url: ""),
            location: LocationResponse(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z"
        )
    }
}
