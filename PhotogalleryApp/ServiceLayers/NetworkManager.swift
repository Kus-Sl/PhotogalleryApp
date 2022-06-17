//
//  NetworkManager.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 09.06.2022.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    private init () {}

    func fetch<T: Decodable>(dataType: T.Type, url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let dataURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: dataURL) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    func fetchPhoto(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let photoURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        DispatchQueue.global().async {
            guard let photoData = try? Data(contentsOf: photoURL) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(photoData))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum PhotoLink: String {
    case classicApi = "https://picsum.photos/v2/list?page=25"
    case blurApi = "https://picsum.photos/300/300/?blur"
    case grayscaleApi = "https://picsum.photos/300/300?grayscale"
}

