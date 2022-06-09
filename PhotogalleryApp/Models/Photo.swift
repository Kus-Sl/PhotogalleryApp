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

enum Link: String {
    case classicURL =  "https://picsum.photos/v2/list?page=25"
    case blurURL = "1"
    case grayscaleURL = "2"
}
