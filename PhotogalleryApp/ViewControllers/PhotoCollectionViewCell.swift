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

    let images = [UIImage(named: "Image1"), UIImage(named: "Image2")].compactMap({ $0 })

    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
}
