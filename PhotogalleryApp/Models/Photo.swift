//
//  Photo.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 09.06.2022.
//

import Foundation

struct Photo: Decodable {

    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?

    init(download_url: String) {
        self.download_url = download_url
        self.id = nil
        self.author = nil
        self.width = nil
        self.height = nil
        self.url = nil
    }
}
