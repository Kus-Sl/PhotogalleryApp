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

    func fetchPhotos(url: String, completionHandler: @escaping ([Photo]?) -> Void) {

        guard let dataURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: dataURL) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                print("Error on GET request level")
                return
            }

            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    print(photos)
                    completionHandler(photos)
                }
            } catch let error {
                print(error.localizedDescription)
                print("Error on decode level")
            }
        }.resume()
    }

    func fetchPhoto(url: String, completionHandler: @escaping (Data) -> Void) {
        guard let photoURL = URL(string: url) else { return }
        guard let photoData = try? Data(contentsOf: photoURL) else { return }
        DispatchQueue.main.async {
            completionHandler(photoData)
        }
    }


}
