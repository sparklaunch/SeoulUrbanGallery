//
//  UrbanGalleryManager.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

@MainActor class UrbanGalleryManager: ObservableObject {
    @Published private var _urbanGallery: [UrbanGallery] = []
    private var customDirectory: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("Custom")
    }
    var count: Int = 0
    var urbanGallery: [UrbanGallery] {
        get {
            _urbanGallery.sorted()
        }
        set {
            _urbanGallery = newValue
        }
    }
    private var endPoint: URL {
        let endPointString = "http://openapi.seoul.go.kr:8088/49497a51466c696e33355546774f7a/json/gongGongArtGallery/1/1000"
        return URL(string: endPointString)!
    }
    private func makeCustomDirectory() {
        if !FileManager.default.fileExists(atPath: customDirectory.path) {
            do {
                try FileManager.default.createDirectory(atPath: customDirectory.path, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    private func loadCustomData() -> [UrbanGallery] {
        makeCustomDirectory()
        guard let customURLs = try? FileManager.default.contentsOfDirectory(at: customDirectory, includingPropertiesForKeys: nil) else {
            fatalError("Failed to load custom directory.")
        }
        var customUrbanGallery: [UrbanGallery] = []
        for url in customURLs {
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load custom data.")
            }
            guard let decodedData = try? JSONDecoder().decode(CustomUrbanGallery.self, from: data) else {
                fatalError("Failed to decode custom data.")
            }
            customUrbanGallery.append(decodedData.toUrbanGallery())
        }
        return customUrbanGallery
    }
    func loadData() async {
        guard let (data, _) = try? await URLSession.shared.data(from: endPoint) else {
            fatalError("Failed to load data.")
        }
        guard let decodedData = try? JSONDecoder().decode(UrbanGalleryHeader.self, from: data) else {
            fatalError("Failed to decode data.")
        }
        let customs = loadCustomData()
        urbanGallery = decodedData.header.rows + customs
        count = decodedData.header.count + customs.count
    }
    func searchedUrbanGallery(with searchText: String) -> [UrbanGallery] {
        if searchText.isEmpty {
            return urbanGallery
        } else {
            return urbanGallery.filter { urbanGallery in
                urbanGallery.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    func add(_ customUrbanGallery: UrbanGallery) {
        save(customUrbanGallery)
        urbanGallery.append(customUrbanGallery)
    }
    private func save(_ customUrbanGallery: UrbanGallery) {
        let targetURL = customDirectory.appendingPathComponent(String(customUrbanGallery.id))
        let custom = CustomUrbanGallery(from: customUrbanGallery)
        guard let encodedUrbanGallery = try? JSONEncoder().encode(custom) else {
            fatalError("Failed to encode custom urban gallery.")
        }
        do {
            try encodedUrbanGallery.write(to: targetURL, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
}
