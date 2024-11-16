//
//  CharactersView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 13/11/24.
//

import SwiftUI

struct CharactersView: View {
    @State internal var navigationPath = NavigationPath()
    @State internal var viewModel: CharactersViewModel
    @State internal var showFilters = false

    init(viewModel: CharactersViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                searchTextField
                filtersHeaderView
                if showFilters {
                    genderSelectionView
                    statusSelectionView
                }
                switch viewModel.viewState {
                    case .loading:
                        LoadingView()
                    case .idle:
                        charactersListView
                    case .error(let errorMessage):
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    case .empty:
                        noContentView
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("characters.title")
            .task(viewModel.onAppear)
            .onChange(of: viewModel.searchFilters.characterGender) { oldValue, newValue in
                Task {
                    await viewModel.fetchCharacters()
                }
            }
            .onChange(of: viewModel.searchFilters.characterStatus) { oldValue, newValue in
                Task {
                    await viewModel.fetchCharacters()
                }
            }
            .navigationDestination(for: Routing.self) { route in
                switch route {
                case .characterDetail(let character):
                    CharacterDetailView(character: character)
                }
            }
        }.tint(.black)
    }
}

#Preview {
    CharactersView(viewModel: CharactersViewModel(fetchCharactersUseCase: FetchCharactersUseCaseImpl(repository: CharactersRepositoryImpl(dataSource: CharactersDataSourceImpl(apiClient: APIClient())))))
}
