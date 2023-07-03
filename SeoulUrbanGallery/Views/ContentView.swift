//
//  ContentView.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var urbanGalleryManager: UrbanGalleryManager
    @State private var isLoading = false
    var body: some View {
        ZStack {
            TabView {
                MainView()
                    .tabItem {
                        Label("갤러리", systemImage: "photo.artframe")
                    }
                FavoritesView()
                    .tabItem {
                        Label("즐겨찾기", systemImage: "star")
                    }
            }
            .task {
                isLoading = true
                await urbanGalleryManager.loadData()
                isLoading = false
            }
            if isLoading {
                ProgressView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UrbanGalleryManager())
    }
}
