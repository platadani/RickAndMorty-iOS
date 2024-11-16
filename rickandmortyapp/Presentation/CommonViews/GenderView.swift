//
//  GenderView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import SwiftUI

struct GenderView: View {
    var gender: CharacterGender

    var body: some View {
        HStack {
            Image(systemName: "figure.dress.line.vertical.figure")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .foregroundStyle(.black)
            Text(gender.textDescription)
        }
    }
}

#Preview {
    GenderView(gender: .female)
    GenderView(gender: .male)
    GenderView(gender: .genderless)
    GenderView(gender: .unknown)
}
