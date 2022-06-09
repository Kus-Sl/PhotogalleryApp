//
//  StartViewController.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 08.06.2022.
//

import UIKit

class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        guard let galleryVC = segue.destination as? GalleryCollectionViewController
        else { return }
        galleryVC.title = segueIdentifier

        switch segueIdentifier {
        case TypeGallery.classic.rawValue:
            galleryVC.createGallery(by: Link.classicURL.rawValue)
        case TypeGallery.blur.rawValue:
            galleryVC.createGallery(by: Link.classicURL.rawValue)
        default:
            galleryVC.createGallery(by: Link.classicURL.rawValue)
        }
    }
}

enum TypeGallery: String {
    case classic = "Classic Photos"
    case blur = "Blur Photos"
    case grayscale = "Grayscale Photos"
}
