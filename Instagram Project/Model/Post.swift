//
//  Post.swift
//  Instagram Project
//
//  Created by PoGo on 10/30/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    let user: User
    let caption: String
    let timeStamp: Int
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.timeStamp = dictionary["creationDate"] as? Int ?? 0
 
    }
    
    
}
