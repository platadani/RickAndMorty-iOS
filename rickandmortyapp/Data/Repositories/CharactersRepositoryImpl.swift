//
//  CharactersRepository.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

class CharactersRepositoryImpl: CharactersRepository {
    private let dataSource: CharactersDataSource

    init(dataSource: CharactersDataSource) {
        self.dataSource = dataSource
    }

    func fetchCharacters(queryParams: [String: String]?) async throws -> RickAndMortyResponse {
        try await dataSource.fetchCharacters(queryParams: queryParams)
    }
}
