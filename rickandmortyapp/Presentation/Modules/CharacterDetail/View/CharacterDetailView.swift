//
//  CharacterDetailView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: RMCharacter

    var body: some View {
        VStack {
            ZStack {
                backgroundBlurImage
                characterImageView
            }
            HSeparatorView(height: 10)
            characterNameTitle
            HStack(spacing: 50) {
                StatusView(status: character.status)
                GenderView(gender: character.gender)
                SpeciesView(species: character.species)
            }
            HSeparatorView()
            if character.hasSubspecie {
                subspecieCardView
            }
            HStack {
                lastKnownLocationCardView
                originLocationCardView
            }
            episodesCardView
            Spacer()
        }.padding(.horizontal, 20)
    }
}

#Preview {
    CharacterDetailView(character: .mock)
}
