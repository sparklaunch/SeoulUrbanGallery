//
//  PhotoLibraryManager.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

class PhotoLibraryManager {
    static func saveToPhotoLibrary(_ imageName: String) {
        let image = UIImage(named: imageName)!
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
