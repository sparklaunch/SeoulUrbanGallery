//
//  FavoritesManager.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

@MainActor class FavoritesManager: ObservableObject {
    @Published private var _favorites: [UrbanGallery] = []
    private var targetURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("Favorites")
    }
    var favorites: [UrbanGallery] {
        get {
            _favorites.sorted()
        }
        set {
            _favorites = newValue
        }
    }
    init() {
        loadData()
    }
    func loadData() {
        if let data = try? Data(contentsOf: targetURL) {
            guard let decodedData = try? JSONDecoder().decode([UrbanGallery].self, from: data) else {
                fatalError("Failed to decode data.")
            }
            favorites = decodedData
        } else {
            favorites = []
        }
    }
    func saveData() {
        guard let encodedData = try? JSONEncoder().encode(favorites) else {
            fatalError("Failed to encode data.")
        }
        do {
            try encodedData.write(to: targetURL, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    func has(_ urbanGallery: UrbanGallery) -> Bool {
        favorites.contains(urbanGallery)
    }
    func add(_ urbanGallery: UrbanGallery) {
        favorites.append(urbanGallery)
        saveData()
    }
    func remove(_ urbanGallery: UrbanGallery) {
        if let index = favorites.firstIndex(of: urbanGallery) {
            favorites.remove(at: index)
            saveData()
        }
    }
    func delete(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
        saveData()
    }
}
