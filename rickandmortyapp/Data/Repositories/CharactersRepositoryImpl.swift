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

    func fetchCharacters(queryParams: [String: String]?) async throws -> (characters: [RMCharacter], nextPage: Int?) {
        let response = try await dataSource.fetchCharacters(queryParams: queryParams)
        return (response.results.map(RMCharacter.init), response.info.nextPage)
    }
}
