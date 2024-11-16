//
//  RickAndMortyResponse.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

struct RickAndMortyResponse: Codable {
    let info: InfoResponse
    let results: [CharacterResponse]
}

extension RickAndMortyResponse {
    static var mock: RickAndMortyResponse {
        RickAndMortyResponse(info: InfoResponse(count: 1, pages: 1, next: "", prev: ""), results: [CharacterResponse.mock])
    }
}
