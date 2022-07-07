//
//  PhotoCollectionViewCell.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 08.06.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photo: UIImageView!
    
    static let identifier = "PhotoCell"

    func configureCell(with image: Photo?, and indexPath: IndexPath) {
        tag = indexPath.item

        let cacheKey = String(indexPath.row) as NSString

        if let cachedImage = CacheManager.shared.cache.object(forKey: cacheKey)  {
            photo.image = cachedImage
            activityIndicator.stopAnimating()
            return
        }

        guard let photoURL = image?.downloadUrl else { return }

        NetworkManager.shared.fetchPhoto(from: photoURL) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                CacheManager.shared.cache.setObject(image, forKey: cacheKey)

                // Переделать проверку на остановку таски и перенести всю логику в NetworkManager

                // Этой строчкой захватываю значение индекса на момент вызова всего метода
                guard self?.tag == indexPath.item else { return }

                // Поймать отличия в ячейках
                self?.photo.image = image
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        photo.image = nil
        activityIndicator.startAnimating()
    }
}

class CacheManager {

    let cache = NSCache<NSString, UIImage>()

    static let shared = CacheManager()

    private init() {}
}

