//
//  Photo.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 09.06.2022.
//

import Foundation

struct Photo: Codable {

    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
}

enum PhotoLink: String {
    case classicApi =  "https://picsum.photos/v2/list?page=1"
    case blurApi = "1"
    case grayscaleApi = "2"
}

