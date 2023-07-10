//
//  PhotosPickerManager.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/10.
//

import PhotosUI
import SwiftUI

@MainActor class PhotosPickerManager: ObservableObject {
    @Published var item: PhotosPickerItem? {
        didSet {
            Task {
                guard let data = try? await item?.loadTransferable(type: Data.self) else {
                    fatalError("Failed to load transferable.")
                }
                imageData = data
                guard let uiImage = UIImage(data: data) else {
                    fatalError("Failed to convert image.")
                }
                image = Image(uiImage: uiImage)
            }
        }
    }
    @Published var image: Image?
    var imageData: Data?
}
