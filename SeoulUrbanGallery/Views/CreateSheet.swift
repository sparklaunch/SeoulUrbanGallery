//
//  CreateSheet.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/10.
//

import PhotosUI
import SwiftUI

struct CreateSheet: View {
    @State private var title = ""
    @State private var location = ""
    @State private var yearInstalled = 2023
    @State private var classification = ""
    @StateObject private var photosPickerManager = PhotosPickerManager()
    var body: some View {
        Form {
            Section("기본 정보") {
                TextField("작품명을 입력하세요", text: $title)
                TextField("소재지를 입력하세요", text: $location)
                Picker("설치 연도를 선택하세요", selection: $yearInstalled) {
                    ForEach(1970..<2024) { year in
                        Text(verbatim: "\(year)")
                            .tag(year)
                    }
                }
                TextField("유형을 입력하세요", text: $classification)
            }
            Section("이미지") {
                PhotosPicker("이미지 선택", selection: $photosPickerManager.item, matching: .images)
                photosPickerManager.image?
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

struct CreateSheet_Previews: PreviewProvider {
    static var previews: some View {
        CreateSheet()
            .environmentObject(PhotosPickerManager())
    }
}
