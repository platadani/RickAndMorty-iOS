//
//  CharacterDetailViewComponents.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import SwiftUI

extension CharacterDetailView {
    var backgroundBlurImage: some View {
        Group {
            if let imageURL = character.image {
                AsyncImageView(url: imageURL,
                               placeholder: Image(systemName: "photo.fill"))
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.screenWidth, height: 250)
                .ignoresSafeArea()
                .blur(radius: 15)

            } else {
                PlaceholderImageView()
            }
        }
    }

    var characterImageView: some View {
        Group {
            if let imageURL = character.image {
                AsyncImageView(url: imageURL,
                               placeholder: Image(systemName: "photo.fill"))
                .aspectRatio(contentMode: .fit)
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                PlaceholderImageView()
            }
        }
    }

    var characterNameTitle: some View {
        Text(character.name)
            .font(.system(size: 24, weight: .bold))
    }

    var subspecieCardView: some View {
        infoCardView(title: String(localized: "subspecie.type.title"), subtitle: character.subspecieType)
    }

    var lastKnownLocationCardView: some View {
        infoCardView(title: String(localized: "lastknowlocation.title"), subtitle: character.lastKnownLocation)
    }

    var originLocationCardView: some View {
        infoCardView(title: String(localized: "originlocation.title"), subtitle: character.originLocation)
    }

    var episodesCardView: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 4)
        return GrayCardView {
            VStack {
                Text("episodes.title")
                LazyVGrid(columns: columns) {
                    ForEach(character.episodes.toRangeStrings(), id: \.self) { episodes in
                        Text(episodes)
                            .font(.system(size: 18, weight: .bold))
                            .padding(5)
                            .background(.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                }
            }
        }
    }

    private func infoCardView(title: String, subtitle: String) -> some View {
        GrayCardView {
            VStack {
                Text(title)
                Text(subtitle)
                    .font(.system(size: 18, weight: .bold))
                    .minimumScaleFactor(0.7)
            }.frame(height: 70)
        }
    }
}
