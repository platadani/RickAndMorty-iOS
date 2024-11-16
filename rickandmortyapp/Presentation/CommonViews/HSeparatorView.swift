//
//  HSeparatorView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import SwiftUI

struct HSeparatorView: View {
    var height: CGFloat = 30

    var body: some View {
        Spacer()
            .frame(height: height)
    }
}

#Preview {
    HSeparatorView()
}
