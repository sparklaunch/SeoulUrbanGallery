//
//  UrbanGallery.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/03.
//

import SwiftUI

struct UrbanGalleryHeader: Codable {
    enum CodingKeys: String, CodingKey {
        case header = "gongGongArtGallery"
    }
    let header: UrbanGalleryBody
}

extension UrbanGalleryHeader {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        header = try container.decode(UrbanGalleryBody.self, forKey: .header)
    }
}

struct UrbanGalleryBody: Codable {
    enum CodingKeys: String, CodingKey {
        case count = "list_total_count"
        case result = "RESULT"
        case rows = "row"
    }
    let count: Int
    let result: UrbanGalleryResult
    let rows: [UrbanGallery]
}

extension UrbanGalleryBody {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        result = try container.decode(UrbanGalleryResult.self, forKey: .result)
        rows = try container.decode([UrbanGallery].self, forKey: .rows)
    }
}

struct UrbanGalleryResult: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
    let code: String
    let message: String
}

extension UrbanGalleryResult {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
    }
}

struct UrbanGallery: Codable {
    static let example = UrbanGallery(title: "쉘터오브메모리즈", yearInstalled: "2012", institute: "서울시", institute2: "디자인정책관", institute3: "디자인정책담당관", location: "서울시 용산구 용산동6가 11-376", detailedLocation: "국립중앙박물관 입구 건너편 정류장", detail: "", classification: "도시갤러리")
    enum CodingKeys: String, CodingKey {
        case title = "GA_KNAME"
        case yearInstalled = "GA_INS_DATE"
        case institute = "CODE_N1_NAME"
        case institute2 = "CODE_N2_NAME"
        case institute3 = "CODE_N3_NAME"
        case location = "GA_ADDR1"
        case detailedLocation = "GA_ADDR2"
        case detail = "GA_DETAIL"
        case classification = "CODE_A1"
    }
    let title: String
    let yearInstalled: String
    let institute: String
    let institute2: String
    let institute3: String
    let location: String
    let detailedLocation: String
    let detail: String
    let classification: String
    var imageName: String {
        title.capitalized.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "!", with: "")
    }
}

extension UrbanGallery {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        yearInstalled = try container.decode(String.self, forKey: .yearInstalled)
        institute = try container.decode(String.self, forKey: .institute)
        institute2 = try container.decode(String.self, forKey: .institute2)
        institute3 = try container.decode(String.self, forKey: .institute3)
        location = try container.decode(String.self, forKey: .location)
        detailedLocation = try container.decode(String.self, forKey: .detailedLocation)
        detail = try container.decode(String.self, forKey: .detail)
        classification = try container.decode(String.self, forKey: .classification)
    }
}

extension UrbanGallery: Comparable {
    static func <(lhs: UrbanGallery, rhs: UrbanGallery) -> Bool {
        lhs.title < rhs.title
    }
}

extension UrbanGallery: Identifiable {
    var id: Int {
        var hasher = Hasher()
        hasher.combine(title)
        hasher.combine(location)
        return hasher.finalize()
    }
}
