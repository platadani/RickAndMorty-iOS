//
//  CharactersUseCase.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Foundation

protocol FetchCharactersUseCase {
    func execute(filters: SearchFilters) async throws -> [RMCharacter]
    func executeNextPage(filters: SearchFilters) async throws -> [RMCharacter]
    func isMoreDataAvailable() -> Bool
}

class FetchCharactersUseCaseImpl: FetchCharactersUseCase {
    private let repository: CharactersRepository

    private var nextPage: Int?

    init(repository: CharactersRepository) {
        self.repository = repository
    }

    func execute(filters: SearchFilters) async throws -> [RMCharacter] {
        let response = try await repository.fetchCharacters(queryParams: filters.toQueryParameters())
        self.nextPage = response.info.nextPage
        return response.results.map(RMCharacter.init)
    }

    func executeNextPage(filters: SearchFilters) async throws -> [RMCharacter] {
        guard let nextPage else {
            throw CustomError.nextURL
        }
        var queryParameters = filters.toQueryParameters()
        queryParameters["page"] = String(nextPage)
        let response = try await repository.fetchCharacters(queryParams: queryParameters)
        self.nextPage = response.info.nextPage
        return response.results.map(RMCharacter.init)
    }

    func isMoreDataAvailable() -> Bool {
        nextPage != nil
    }
}
