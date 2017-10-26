//
//  User.swift
//  Instagram Project
//
//  Created by PoGo on 10/26/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import Foundation

struct User {
    let userName: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.userName = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
    
    
}
