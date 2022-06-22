//
//  GalleryCollectionViewController.swift
//  PhotogalleryApp
//
//  Created by Вячеслав Кусакин on 08.06.2022.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {

    var photos: [Photo]?

    private let cells: CGFloat = 3
    private let spacing: CGFloat = 3

    func createClassicGallery(by url: String) {
        NetworkManager.shared.fetch(dataType: [Photo].self, url: PhotoLinks.classicApi.rawValue) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    func createBlurOrGrayscaleGallery(by url: String) {
        photos = [Photo](repeating: Photo(downloadUrl: url), count: 30)
    }
}

// MARK: UICollectionViewDataSource
extension GalleryCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell

        cell.configure(by: photos?[indexPath.item])

        return cell
    }
}

// MARK: UICollectionViewDelegate
extension GalleryCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacingForCell = (cells + 1) * spacing / cells
        let fullSizeCell = collectionView.frame.width / cells

        let sizeCell = fullSizeCell - spacingForCell

        return CGSize(width: sizeCell, height: sizeCell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
    }
}
