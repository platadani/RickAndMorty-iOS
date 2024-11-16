//
//  MockCharactersDataSource.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

@testable import rickandmortyapp

class MockCharactersDataSource: CharactersDataSource {
    var shouldReturnError = false

    func fetchCharacters(queryParams: [String : String]?) async throws -> RickAndMortyResponse {
        if shouldReturnError {
            throw CustomError.unknown
        } else {
            return .mock
        }
    }
}
