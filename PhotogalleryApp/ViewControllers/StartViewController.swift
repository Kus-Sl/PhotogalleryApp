//
//  StartViewController.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 08.06.2022.
//

import UIKit

class StartViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let galleryVC = segue.destination as? GalleryCollectionViewController else { return }
        guard let segueID = segue.identifier else { return }
        guard let typeGallery = Segue.init(rawValue: segueID) else { return }
        galleryVC.title = typeGallery.rawValue
        
        switch typeGallery {
        case .classic:
            galleryVC.createClassicGallery(by: PhotoLinks.classicApi.rawValue)
        case .blur:
            galleryVC.createBlurOrGrayscaleGallery(by: PhotoLinks.blurApi.rawValue)
        case .grayscale:
            galleryVC.createBlurOrGrayscaleGallery(by: PhotoLinks.grayscaleApi.rawValue)
        }
    }

    private enum Segue: String {
        case classic = "Classic Photos"
        case blur = "Blur Photos"
        case grayscale = "Grayscale Photos"
}
}
