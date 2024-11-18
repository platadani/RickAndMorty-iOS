//
//  MockCharactersRepository.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//
@testable import rickandmortyapp

class MockCharactersRepository: CharactersRepository {
    var shouldReturnError = false
    var nextPage: Int?
    var mockModel: [RMCharacter] = [.mock]

    func fetchCharacters(queryParams: [String: String]?) async throws -> (characters: [RMCharacter], nextPage: Int?) {
        if shouldReturnError {
            throw CustomError.invalidURL
        } else {
            return (mockModel, nextPage)
        }
    }
}
