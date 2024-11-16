//
//  AsyncImageView.swift
//  rickandmortyapp
//
//  Created by Daniel Plata on 14/11/24.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL
    let placeholder: Image
    @State private var image: Image?
    @State private var isLoading: Bool = true
    
    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
            } else if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                PlaceholderImageView()
                    .padding(30)
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        do {
            image = try await fetchImage(from: url)
            isLoading = false
        } catch {
            print("Error loading image: \(error)")
            isLoading = false
        }
    }

    private func fetchImage(from url: URL) async throws -> Image {
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 60)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let uiImage = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }

        return Image(uiImage: uiImage)
    }
}
