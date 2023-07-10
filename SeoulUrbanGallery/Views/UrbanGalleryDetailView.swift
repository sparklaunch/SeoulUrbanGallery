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
    private var customImage: Image {
        guard let targetURL = urbanGallery.customImageURL else {
            fatalError("Failed to load custom image")
        }
        guard let imageData = try? Data(contentsOf: targetURL) else {
            fatalError("Failed to load custom image data")
        }
        guard let uiImage = UIImage(data: imageData) else {
            fatalError("Failed to convert data to image")
        }
        return Image(uiImage: uiImage)
    }
    private var image: Image {
        if urbanGallery.isCustom {
            return customImage
        } else {
            return Image(urbanGallery.imageName)
        }
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                image
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
