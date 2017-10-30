//
//  PhotoSelectorController.swift
//  Instagram Project
//
//  Created by PoGo on 10/29/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Photos

private let photoCell = "photoCell"
private let headerId = "headerId"

class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        self.collectionView!.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: photoCell)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        setupNavigationButtons()
        fetchPhotos()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setupNavigationButtons(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
  
    }
    
    func fetchPhotos(){
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        allPhotos.enumerateObjects { (asset, count, stop) in
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: option, resultHandler: { (image, info) in
                if let image = image{
                    self.images.append(image)
                }
                if count == allPhotos.count - 1{
                    self.collectionView?.reloadData()
                }
            
            })
        }
        
        
    }
    
   @objc func handleCancel(){
         dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext(){
        
        
        
    }

}

extension PhotoSelectorController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as? PhotoSelectorCell{
            cell.photoImageView.image = images[indexPath.item]
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        header.backgroundColor = .gray
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1, 0, 0, 0)
    }
}
