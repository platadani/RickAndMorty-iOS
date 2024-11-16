//
//  CharactersDataSource.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Foundation

protocol CharactersDataSource {
    func fetchCharacters(queryParams: [String: String]?) async throws -> RickAndMortyResponse
}


