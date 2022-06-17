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
    
    func configure(by photo: Photo?) {
        guard let photoURL = photo?.downloadUrl else { return }
        NetworkManager.shared.fetchPhoto(url: photoURL) { result in
            switch result {
            case .success(let data):
                self.photo.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
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
