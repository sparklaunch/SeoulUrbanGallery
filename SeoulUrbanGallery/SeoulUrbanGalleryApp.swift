//
//  SeoulUrbanGalleryApp.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

@main
struct SeoulUrbanGalleryApp: App {
    @StateObject private var urbanGalleryManager = UrbanGalleryManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(urbanGalleryManager)
        }
    }
}
