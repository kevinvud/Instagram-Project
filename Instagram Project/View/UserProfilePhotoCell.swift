//
//  UserProfilePhotoCell.swift
//  Instagram Project
//
//  Created by PoGo on 10/30/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            guard let imageUrl = post?.imageUrl else {return}
            photoImageView.loadImage(urlString: imageUrl)
        
        }
    }
    
    let photoImageView: CustomImageView = {
       let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error in user photo cell")
    }
    
    func setupViews(){
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
}
