//
//  MockFetchCharactersUseCase.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

@testable import rickandmortyapp

class MockFetchCharactersUseCase: FetchCharactersUseCase {
    var shouldReturnError = false
    var nextPage: Int?
    var mockModel: [RMCharacter] = [.mock]

    func execute(filters: SearchFilters, page: Int? = nil) async throws -> ([RMCharacter], Int?) {
        if shouldReturnError {
            throw CustomError.unknown
        } else {
            return (mockModel, nextPage)
        }
    }
}
