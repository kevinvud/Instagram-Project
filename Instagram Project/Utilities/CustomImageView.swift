//
//  CustomImageView.swift
//  Instagram Project
//
//  Created by PoGo on 10/30/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    var lastURLUserToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUserToLoadImage = urlString
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                print("Failed to fetch post image:", err)
                return
            }
            if url.absoluteString != self.lastURLUserToLoadImage{
                return
            }
            guard let imageData = data else {return}
            let photoImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
        
        
    }
    
    
    
    
    
}
