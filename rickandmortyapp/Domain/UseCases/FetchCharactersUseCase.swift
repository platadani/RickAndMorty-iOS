//
//  CharactersUseCase.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Foundation

protocol FetchCharactersUseCase {
    func execute(filters: SearchFilters, page: Int?) async throws -> (characters: [RMCharacter], nextPage: Int?)
}

class FetchCharactersUseCaseImpl: FetchCharactersUseCase {
    private let repository: CharactersRepository

    init(repository: CharactersRepository) {
        self.repository = repository
    }

    func execute(filters: SearchFilters, page: Int? = nil) async throws -> (characters: [RMCharacter], nextPage: Int?) {
        var queryParameters = filters.toQueryParameters()
        if let page {
            queryParameters["page"] = String(page)
        }
        let response = try await repository.fetchCharacters(queryParams: queryParameters)
        return (response.characters, response.nextPage)
    }
}
