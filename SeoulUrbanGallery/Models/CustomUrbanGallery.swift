//
//  CustomUrbanGallery.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/11.
//

import SwiftUI

struct CustomUrbanGallery: Codable {
    let title: String
    let yearInstalled: String
    let institute: String
    let institute2: String
    let institute3: String
    let location: String
    let detailedLocation: String
    let detail: String
    let classification: String
    let customImageFileName: String
    init(from urbanGallery: UrbanGallery) {
        title = urbanGallery.title
        yearInstalled = urbanGallery.yearInstalled
        institute = urbanGallery.institute
        institute2 = urbanGallery.institute2
        institute3 = urbanGallery.institute3
        location = urbanGallery.location
        detailedLocation = urbanGallery.detailedLocation
        detail = urbanGallery.detail
        classification = urbanGallery.classification
        customImageFileName = urbanGallery.customImageFileName!
    }
    func toUrbanGallery() -> UrbanGallery {
        UrbanGallery(title: self.title, yearInstalled: self.yearInstalled, institute: self.institute, institute2: self.institute2, institute3: self.institute3, location: self.location, detailedLocation: self.detailedLocation, detail: self.detail, classification: self.classification, isCustom: true, customImageFileName: self.customImageFileName)
    }
}
