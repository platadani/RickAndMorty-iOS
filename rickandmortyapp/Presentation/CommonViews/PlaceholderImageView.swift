//
//  PlaceholderImageView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import SwiftUI

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }
}
