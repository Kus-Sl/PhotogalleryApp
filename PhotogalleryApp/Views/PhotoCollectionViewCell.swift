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

    func configure(with image: Photo?, and indexPath: IndexPath) {
        tag = indexPath.item

        let cacheKey = indexPath.item

        if let cachedImage = CacheManager.shared.cache.object(forKey: cacheKey as NSNumber)  {
            photo.image = cachedImage
            activityIndicator.stopAnimating()
            return
        }

        guard let photoURL = image?.downloadUrl else { return }

        NetworkManager.shared.fetchPhoto(from: photoURL) { [weak self] result in
            switch result {
            case .success(let data):
                guard self?.tag == cacheKey else { return }

                guard let image = UIImage(data: data) else { return }

                self?.photo.image = image
                self?.activityIndicator.stopAnimating()

                CacheManager.shared.cache.setObject(image, forKey: cacheKey as NSNumber)
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

    let cache = NSCache<NSNumber, UIImage>()

    static let shared = CacheManager()

    private init() {}
}

