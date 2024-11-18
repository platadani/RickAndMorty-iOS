//
//  CharactersViewComponents.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 14/11/24.
//

import SwiftUI

extension CharactersView {
    var searchTextField: some View {
        TextField("characters.textfield.placeholder",
                  text: $viewModel.searchFilters.nameQuery,
                  onCommit: {
            Task {
                await viewModel.fetchCharacters()
            }
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
    }

    var filtersHeaderView: some View {
        HStack {
            Text("filters.title")
            Image(systemName: showFilters ? "chevron.up" : "chevron.down")
            Spacer()
        }.padding(.horizontal)
            .contentShape(Rectangle())
            .onTapGesture {
                showFilters.toggle()
            }
    }

    var genderSelectionView: some View {
        HStack {
            ForEach(CharacterGender.filterCases) { gender in
                let isGenderSelected = viewModel.searchFilters.characterGender == gender
                Text(gender.textDescription)
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(isGenderSelected ? .black : .white)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: isGenderSelected ? 2 : 0.5)
                            .foregroundStyle(isGenderSelected ? .black : .gray)
                    }.onTapGesture {
                        viewModel.searchFilters.setGender(gender)
                    }
                    .foregroundStyle(isGenderSelected ? Color.white : Color.black)
            }
            Spacer()
        }.padding(.horizontal)
    }

    var statusSelectionView: some View {
        HStack {
            ForEach(CharacterStatus.filterCases) { status in
                let isStatusSelected = viewModel.searchFilters.characterStatus == status
                Text(status.textDescription)
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(isStatusSelected ? .black : .white)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: isStatusSelected ? 2 : 0.5)
                            .foregroundStyle(isStatusSelected ? .black : .gray)
                    }.onTapGesture {
                        viewModel.searchFilters.setStatus(status)
                    }
                    .foregroundStyle(isStatusSelected ? Color.white : Color.black)
            }
            Spacer()
        }.padding(.horizontal)
    }

    var charactersListView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.rmCharacters ?? [], id: \.id) { character in
                    characterRow(character: character)
                        .onTapGesture {
                            navigationPath.append(Routing.characterDetail(character))
                        }
                }
                lastRowView
            }
            .padding()
        }
    }

    @ViewBuilder private func characterRow(character: RMCharacter) -> some View {
        HStack {
            if let imageURL = character.image {
                AsyncImageView(url: imageURL,
                               placeholder: Image(systemName: "photo.fill"))
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            } else {
                PlaceholderImageView()
            }
            VStack(alignment: .leading) {
                Text(character.name)
                StatusView(status: character.status)
                GenderView(gender: character.gender)
                SpeciesView(species: character.species)
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 0.1)
                .foregroundStyle(.black)
        }
    }
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.paginationState {
                case .isLoading:
                    LoadingView()
                case .idle:
                    EmptyView()
                case .error(let error):
                    Text(error)
            }
        }
        .frame(height: 50)
        .task {
            if viewModel.nextPage != nil {
                await viewModel.fetchMoreCharacters()
            }
        }
    }

    var noContentView: some View {
        ContentUnavailableView(
            "nocontent.title",
            systemImage: "magnifyingglass.circle.fill",
            description: Text("nocontent.description")
        )
    }
}
