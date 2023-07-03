//
//  FavoritesView.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesManager: FavoritesManager
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(favoritesManager.searchedFavorites(with: searchText)) { favorite in
                    NavigationLink {
                        UrbanGalleryDetailView(urbanGallery: favorite)
                    } label: {
                        UrbanGalleryRow(urbanGallery: favorite)
                    }
                }
                .onDelete(perform: favoritesManager.delete)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .navigationTitle("즐겨찾기 (\(favoritesManager.searchedFavorites(with: searchText).count))")
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
