//
//  rickandmortyappApp.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import SwiftUI

@main
struct rickandmortyappApp: App {
    init() {
        configureURLCache()
    }

    private func configureURLCache() {
        let memoryCapacity = 50 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "imageCache")
        URLCache.shared = cache
    }

    var body: some Scene {
        WindowGroup {
            let apiClient = APIClient()
            let requestConfiguration = CharactersRequestConfiguration()
            let dataSource = CharactersDataSourceImpl(apiClient: apiClient, requestConfiguration: requestConfiguration, cacheClient: CacheClient())
            let repository = CharactersRepositoryImpl(dataSource: dataSource)
            let fetchCharactersUseCase = FetchCharactersUseCaseImpl(repository: repository)
            let viewModel = CharactersViewModel(fetchCharactersUseCase: fetchCharactersUseCase)

            CharactersView(viewModel: viewModel)
        }
    }
}
