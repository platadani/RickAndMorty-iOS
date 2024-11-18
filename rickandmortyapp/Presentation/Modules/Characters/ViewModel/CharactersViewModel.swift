//
//  CharactersViewModel.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import Foundation
import Observation
import Combine

@MainActor
@Observable
class CharactersViewModel {
    private let fetchCharactersUseCase: FetchCharactersUseCase
    var rmCharacters: [RMCharacter]? {
        didSet {
            if let rmCharacters, rmCharacters.isEmpty {
                viewState = .empty
            } else {
                viewState = .idle
            }
            paginationState = .idle
        }
    }
    var searchFilters = SearchFilters()
    var viewState: ViewState = .idle
    var paginationState: PaginationState = .idle
    var nextPage: Int?

    init(fetchCharactersUseCase: FetchCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }

    @Sendable
    func onAppear() async {
        await fetchCharacters()
    }

    func fetchCharacters() async {
        do {
            viewState = .loading
            let (newCharacters, nextPage) = try await fetchCharactersUseCase.execute(filters: searchFilters, page: nil)
            self.nextPage = nextPage
            rmCharacters = newCharacters
        } catch {
            await handleError(error)
        }
    }

    func fetchMoreCharacters() async {
        do {
            paginationState = .isLoading
            let (newCharacters, nextPage) = try await fetchCharactersUseCase.execute(filters: searchFilters, page: nextPage)
            self.nextPage = nextPage
            rmCharacters = newCharacters
        } catch {
            await handleError(error)
        }
    }

    private func handleError(_ error: Error) async {
        rmCharacters = []
        guard let customError = error as? CustomError else { return }
        switch customError {
            case .invalidURL, .httpError, .nextURL, .unknown:
                viewState = .error(customError.displayError ?? "")
            case .notFound:
                viewState = .empty
        }
    }
}
