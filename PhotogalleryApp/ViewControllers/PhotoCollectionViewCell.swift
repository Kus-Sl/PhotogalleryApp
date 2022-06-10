//
//  PhotoCollectionViewCell.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 08.06.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    static let identifier = "PhotoCell"
    
    func configure(by photo: Photo?) {
        guard let photoURL = photo?.download_url else { return }
        DispatchQueue.global().async {
            NetworkManager.shared.fetchPhoto(url: photoURL) { data in
                self.photo.image = UIImage(data: data)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
}
