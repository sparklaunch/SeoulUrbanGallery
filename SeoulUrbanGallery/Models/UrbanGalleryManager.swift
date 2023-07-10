//
//  UrbanGalleryManager.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

@MainActor class UrbanGalleryManager: ObservableObject {
    @Published private var _urbanGallery: [UrbanGallery] = []
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
    func loadData() async {
        guard let (data, _) = try? await URLSession.shared.data(from: endPoint) else {
            fatalError("Failed to load data.")
        }
        guard let decodedData = try? JSONDecoder().decode(UrbanGalleryHeader.self, from: data) else {
            fatalError("Failed to decode data.")
        }
        urbanGallery = decodedData.header.rows
        count = decodedData.header.count
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
        urbanGallery.append(customUrbanGallery)
    }
}
