//
//  SpeciesView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import SwiftUI

struct SpeciesView: View {
    var species: String

    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .foregroundStyle(.black)
            Text(species)
        }
    }
}

#Preview {
    SpeciesView(species: "Human")
}
