//
//  UrbanGalleryDetailView.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct UrbanGalleryDetailView: View {
    @EnvironmentObject private var favoritesManager: FavoritesManager
    let urbanGallery: UrbanGallery
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(urbanGallery.imageName)
                    .resizable()
                    .scaledToFit()
                    .contextMenu {
                        Button {
                            PhotoLibraryManager.saveToPhotoLibrary(urbanGallery.imageName)
                        } label: {
                            Label("이미지 저장", systemImage: "photo")
                        }
                    }
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(urbanGallery.title)
                            .font(.largeTitle.bold())
                        Spacer()
                        if favoritesManager.has(urbanGallery) {
                            Button {
                                favoritesManager.remove(urbanGallery)
                            } label: {
                                Image(systemName: "star.fill")
                                    .imageScale(.large)
                            }
                        } else {
                            Button {
                                favoritesManager.add(urbanGallery)
                            } label: {
                                Image(systemName: "star")
                                    .imageScale(.large)
                            }
                        }
                    }
                    Text("**소재지**: \(urbanGallery.location), \(urbanGallery.detailedLocation).")
                    Text("**설치 연도**: \(urbanGallery.yearInstalled).")
                    Text("**유형**: \(urbanGallery.classification).")
                    if !urbanGallery.detail.isEmpty {
                        Text("**상세**: \(urbanGallery.detail).")
                    }
                }
                .padding()
            }
            .padding(.bottom, 100)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct UrbanGalleryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UrbanGalleryDetailView(urbanGallery: UrbanGallery.example)
            .environmentObject(FavoritesManager())
    }
}
