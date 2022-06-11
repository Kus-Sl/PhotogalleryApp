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


