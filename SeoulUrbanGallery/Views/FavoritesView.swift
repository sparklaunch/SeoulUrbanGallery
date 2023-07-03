//
//  FavoritesView.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesManager: FavoritesManager
    var body: some View {
        NavigationView {
            List {
                ForEach(favoritesManager.favorites) { favorite in
                    NavigationLink {
                        UrbanGalleryDetailView(urbanGallery: favorite)
                    } label: {
                        UrbanGalleryRow(urbanGallery: favorite)
                    }
                }
                .onDelete(perform: favoritesManager.delete)
            }
            .navigationTitle("즐겨찾기 (\(favoritesManager.favorites.count))")
        }
        .navigationViewStyle(.stack)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesManager())
    }
}
