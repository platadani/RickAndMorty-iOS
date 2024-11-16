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

    private var cancellables = Set<AnyCancellable>()
    var rmCharacters: [RMCharacter]? {
        didSet {
            if let rmCharacters, rmCharacters.isEmpty {
                viewState = .empty
            } else {
                viewState = .idle
            }
        }
    }
    var searchFilters = SearchFilters()
    var viewState: ViewState = .idle
    var paginationState: PaginationState = .idle
    var isMoreDataAvailable: Bool = false

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
            let newCharacters = try await fetchCharactersUseCase.execute(filters: searchFilters)
            isMoreDataAvailable = fetchCharactersUseCase.isMoreDataAvailable()
            rmCharacters = newCharacters
        } catch {
            rmCharacters = []
            await handleError(error)
        }
    }

    func fetchMoreCharacters() async {
        await MainActor.run {
            paginationState = .isLoading
        }
        do {
            let newCharacters = try await fetchCharactersUseCase.executeNextPage(filters: searchFilters)
            isMoreDataAvailable = fetchCharactersUseCase.isMoreDataAvailable()
            rmCharacters?.append(contentsOf: newCharacters)
            paginationState = .idle
        } catch {
            rmCharacters = []
            await handleError(error)
        }
    }

    private func handleError(_ error: Error) async {
        await MainActor.run {
            guard let customError = error as? CustomError else { return }
            switch customError {
                case .invalidURL, .httpError, .nextURL, .unknown:
                    viewState = .error(customError.displayError ?? "")
                case .notFound:
                    viewState = .empty
            }
        }
    }
}
