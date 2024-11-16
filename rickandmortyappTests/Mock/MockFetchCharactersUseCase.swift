//
//  MockFetchCharactersUseCase.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

@testable import rickandmortyapp

class MockFetchCharactersUseCase: FetchCharactersUseCase {
    var shouldReturnError = false
    var shouldMoreDataAvailable = false

    var mockCharacters: [RMCharacter] = [.mock]

    func execute(filters: rickandmortyapp.SearchFilters) async throws -> [RMCharacter] {
        if shouldReturnError {
            throw CustomError.unknown
        } else {
            return mockCharacters
        }
    }

    func executeNextPage(filters: rickandmortyapp.SearchFilters) async throws -> [RMCharacter] {
        if shouldReturnError {
            throw CustomError.unknown
        } else {
            return mockCharacters
        }
    }

    func isMoreDataAvailable() -> Bool {
        return shouldMoreDataAvailable
    }
}
