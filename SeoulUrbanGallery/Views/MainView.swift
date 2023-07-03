//
//  MainView.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var urbanGalleryManager: UrbanGalleryManager
    var body: some View {
        NavigationView {
            List(urbanGalleryManager.urbanGallery) { urbanGallery in
                NavigationLink {

                } label: {
                    UrbanGalleryRow(urbanGallery: urbanGallery)
                }
            }
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
