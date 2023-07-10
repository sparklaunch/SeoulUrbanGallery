//
//  CreateSheet.swift
//  SeoulUrbanGallery
//
//  Created by Jinwook Kim on 2023/07/10.
//

import PhotosUI
import SwiftUI

struct CreateSheet: View {
    @StateObject private var customGalleryManager = CustomGalleryManager()
    @StateObject private var photosPickerManager = PhotosPickerManager()
    @EnvironmentObject private var urbanGalleryManager: UrbanGalleryManager
    @State private var showingImageAlert = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Form {
                Section("기본 정보") {
                    TextField("작품명을 입력하세요", text: $customGalleryManager.title)
                    TextField("소재지를 입력하세요", text: $customGalleryManager.location)
                    TextField("기관 1을 입력하세요", text: $customGalleryManager.institute)
                    TextField("기관 2를 입력하세요", text: $customGalleryManager.institute2)
                    TextField("기관 3을 입력하세요", text: $customGalleryManager.institute3)
                    TextField("상세 주소를 입력하세요", text: $customGalleryManager.detailedLocation)
                    TextField("유형을 입력하세요", text: $customGalleryManager.classification)
                    Picker("설치 연도를 선택하세요", selection: $customGalleryManager.yearInstalled) {
                        ForEach(1970..<2024) { year in
                            Text(verbatim: "\(year)")
                                .tag(year)
                        }
                    }
                }
                Section("상세 정보") {
                    TextEditor(text: $customGalleryManager.detail)
                }
                Section("이미지") {
                    PhotosPicker("이미지 선택", selection: $photosPickerManager.item, matching: .images)
                    photosPickerManager.image?
                        .resizable()
                        .scaledToFit()
                }
            }
            Spacer()
            Button("등록") {
                if let imageData = photosPickerManager.imageData {
                    do {
                        let urbanGallery = try customGalleryManager.makeUrbanGallery(imageData: imageData)
                        urbanGalleryManager.add(urbanGallery)
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    showingImageAlert = true
                }
            }
            .alert("선택된 이미지 없음", isPresented: $showingImageAlert) {

            }
        }
    }
}

struct CreateSheet_Previews: PreviewProvider {
    static var previews: some View {
        CreateSheet()
            .environmentObject(CustomGalleryManager())
            .environmentObject(PhotosPickerManager())
            .environmentObject(UrbanGalleryManager())
    }
}
