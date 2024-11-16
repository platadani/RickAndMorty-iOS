//
//  CharactersRepository.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 16/11/24.
//

protocol CharactersRepository {
    func fetchCharacters(queryParams: [String: String]?) async throws -> RickAndMortyResponse
}
