//
//  StatusView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 15/11/24.
//

import SwiftUI

struct StatusView: View {
    var status: CharacterStatus

    var body: some View {
        HStack {
            Image(systemName: "livephoto")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .foregroundStyle(accentColor(for: status))
            Text(status.textDescription)
        }
    }

    private func accentColor(for status: CharacterStatus) -> Color {
        switch status {
            case .alive: return .green
            case .dead: return .red
            case .unknown: return .gray
        }
    }
}

#Preview {
    Group {
        StatusView(status: .alive)
        StatusView(status: .dead)
        StatusView(status: .unknown)
    }
}
