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
    let timeStamp: Date
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.timeStamp = Date(timeIntervalSince1970: secondsFrom1970)
 
    }
    
    
}
