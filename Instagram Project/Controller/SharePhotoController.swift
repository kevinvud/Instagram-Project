//
//  SharePhotoController.swift
//  Instagram Project
//
//  Created by PoGo on 10/30/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage?{
        
        didSet{
            self.imageView.image = selectedImage
        }
    }
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        setupImageAndTextViews()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    private func setupImageAndTextViews(){
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(textView)
        
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        
    }
    
    @objc func handleShare(){
        guard let caption = textView.text, caption.characters.count > 0 else {return}
        guard let image = selectedImage else {return}
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else {return}
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("Posts").child(filename).putData(uploadData, metadata: nil) { (metadata, err) in
            
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload post image: ", err)
                return
            }
            guard let imageUrl = metadata?.downloadURL()?.absoluteString else {return}
            
            self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
            
        }
        
        
    }
    
    private func saveToDatabaseWithImageUrl(imageUrl: String){
        guard let postImage = selectedImage else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let caption = textView.text else {return}
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate" : Date().timeIntervalSince1970] as [String: Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("failed to save post to DB", err)
                return
            }
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
    }

}
