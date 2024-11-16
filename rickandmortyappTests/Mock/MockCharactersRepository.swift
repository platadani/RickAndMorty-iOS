//
//  MockCharactersRepository.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//
@testable import rickandmortyapp

class MockCharactersRepository: CharactersRepository {
    var shouldReturnError = false

    var mockResponse: RickAndMortyResponse = .mock

    func fetchCharacters(queryParams: [String: String]?) async throws -> RickAndMortyResponse {
        if shouldReturnError {
            throw CustomError.invalidURL
        } else {
            return mockResponse
        }
    }
}
