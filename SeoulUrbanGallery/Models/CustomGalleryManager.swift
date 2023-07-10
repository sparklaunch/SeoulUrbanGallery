//
//  CustomGalleryManager.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/10.
//

import SwiftUI

@MainActor class CustomGalleryManager: ObservableObject {
    @Published var title = ""
    @Published var location = ""
    @Published var yearInstalled = 2023
    @Published var classification = ""
    func makeUrbanGallery(imageData: Data) throws -> UrbanGallery {
        let genuineTitle: String
        if title.isEmpty {
            genuineTitle = "무제"
        } else {
            genuineTitle = title
        }
        let genuineLocation: String
        if location.isEmpty {
            genuineLocation = "불명"
        } else {
            genuineLocation = location
        }
        let genuineClassification: String
        if classification.isEmpty {
            genuineClassification = "기타"
        } else {
            genuineClassification = classification
        }
        let id = UUID().uuidString
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let targetURL = documentDirectory.appendingPathComponent(id)
        do {
            try imageData.write(to: targetURL, options: [.atomic, .completeFileProtection])
            return UrbanGallery(title: genuineTitle, yearInstalled: String(yearInstalled), institute: "", institute2: "", institute3: "", location: genuineLocation, detailedLocation: "", detail: "", classification: genuineClassification, isCustom: true, customImageURL: targetURL)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
