//
//  UrbanGalleryRow.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct UrbanGalleryRow: View {
    let urbanGallery: UrbanGallery
    var body: some View {
        Text(urbanGallery.title)
    }
}

struct UrbanGalleryRow_Previews: PreviewProvider {
    static var previews: some View {
        UrbanGalleryRow(urbanGallery: UrbanGallery.example)
    }
}
