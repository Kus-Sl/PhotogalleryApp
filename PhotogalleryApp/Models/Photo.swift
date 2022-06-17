//
//  Photo.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 09.06.2022.
//

import Foundation

struct Photo: Decodable {

    let url: String?
    let downloadUrl: String?

    init(downloadUrl: String) {
        self.downloadUrl = downloadUrl
        self.url = nil
    }
}
