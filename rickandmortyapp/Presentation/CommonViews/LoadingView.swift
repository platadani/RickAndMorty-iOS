//
//  LoadingView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 16/11/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }
}

#Preview {
    LoadingView()
}
