//
//  CharactersDataSourceImpl.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 16/11/24.
//

import Foundation

class CharactersDataSourceImpl: CharactersDataSource {
    private let apiClient: APIClientProtocol
    private let cacheClient: CacheClientProtocol
    private let requestConfiguration: CharactersRequestConfiguration

    init(apiClient: APIClientProtocol, requestConfiguration: CharactersRequestConfiguration = CharactersRequestConfiguration(), cacheClient: CacheClientProtocol = CacheClient()) {
        self.apiClient = apiClient
        self.requestConfiguration = requestConfiguration
        self.cacheClient = cacheClient
    }

    func fetchCharacters(queryParams: [String: String]?) async throws -> RickAndMortyResponse {
        guard let url = requestConfiguration.makeCharactersURL(queryParams: queryParams) else {
            throw CustomError.invalidURL
        }
        do {
            let cachedResponse: RickAndMortyResponse = try getCharactersFromCache(url: url)
            print("💾 Fetching characters from cache")
            return cachedResponse
        } catch {
            let networkResponse = try await getCharactersFromNetwork(url: url)
            print("🌏 Fetching characters from network: \(url.absoluteString)")
            try cacheClient.setCache(for: url.absoluteString, decodable: networkResponse)
            return networkResponse
        }
    }

    private func getCharactersFromNetwork(url: URL) async throws -> RickAndMortyResponse {
        try await apiClient.request(url: url, method: .get)
    }

    private func getCharactersFromCache(url: URL) throws -> RickAndMortyResponse {
        try cacheClient.getCache(for: url.absoluteString)
    }
}
