//
//  UserSearchCell.swift
//  Instagram Project
//
//  Created by PoGo on 10/31/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class UserSearchCell: UICollectionViewCell {
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    let userNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let separatorView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return line
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal error in user search cell")
    }
    
    func setupViews(){
        
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(separatorView)
        
        separatorView.anchor(top: nil, left: userNameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        userNameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
    }
    
    
}
