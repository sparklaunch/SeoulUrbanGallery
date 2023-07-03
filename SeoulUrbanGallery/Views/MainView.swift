//
//  MainView.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var urbanGalleryManager: UrbanGalleryManager
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List(urbanGalleryManager.searchedUrbanGallery(with: searchText)) { urbanGallery in
                NavigationLink {
                    UrbanGalleryDetailView(urbanGallery: urbanGallery)
                } label: {
                    UrbanGalleryRow(urbanGallery: urbanGallery)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .navigationTitle("갤러리 (\(urbanGalleryManager.count))")
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UrbanGalleryManager())
    }
}
