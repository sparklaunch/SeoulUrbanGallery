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
    @Published var institute = ""
    @Published var institute2 = ""
    @Published var institute3 = ""
    @Published var detailedLocation = ""
    @Published var detail = ""
    private var genuineTitle: String {
        if title.isEmpty {
            return "무제"
        } else {
            return title
        }
    }
    private var genuineLocation: String {
        if location.isEmpty {
            return "불명"
        } else {
            return location
        }
    }
    private var genuineClassification: String {
        if classification.isEmpty {
            return "기타"
        } else {
            return classification
        }
    }
    private var genuineInstitute: String {
        if institute.isEmpty {
            return "기관 정보 없음"
        } else {
            return institute
        }
    }
    private var genuineInstitute2: String {
        if institute2.isEmpty {
            return "기관 정보 없음"
        } else {
            return institute2
        }
    }
    private var genuineInstitute3: String {
        if institute3.isEmpty {
            return "기관 정보 없음"
        } else {
            return institute3
        }
    }
    private var genuineDetailedLocation: String {
        if detailedLocation.isEmpty {
            return "상세 주소 정보 없음"
        } else {
            return detailedLocation
        }
    }
    func makeUrbanGallery(imageData: Data) throws -> UrbanGallery {
        let id = UUID().uuidString
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let targetURL = documentDirectory.appendingPathComponent(id)
        do {
            try imageData.write(to: targetURL, options: [.atomic, .completeFileProtection])
            return UrbanGallery(title: genuineTitle, yearInstalled: String(yearInstalled), institute: genuineInstitute, institute2: genuineInstitute2, institute3: genuineInstitute3, location: genuineLocation, detailedLocation: genuineDetailedLocation, detail: detail, classification: genuineClassification, isCustom: true, customImageFileName: id)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
