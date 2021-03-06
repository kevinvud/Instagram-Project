//
//  HomeController.swift
//  Instagram Project
//
//  Created by PoGo on 10/30/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.updateFeedNotificationName, object: nil)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        setupNavigationItems()
        fetchAllPosts()
    }
    
    @objc func handleUpdateFeed(){
        handleRefresh()
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchAllPosts()
    }
    
    func fetchAllPosts() {
        fetchPosts()
        fetchFollowingUserIds()
    }
    
    func fetchFollowingUserIds() {

        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userIdsDictionary = snapshot.value as? [String: Any] else {return}
            userIdsDictionary.forEach({ (key,value) in
                Database.fetchUserWithUID(uid: key, completion: { (user) in
                    self.fetchPostWithUser(user: user)
                })
            })
        }) { (error) in
            print("Failed to fetch following user:", error)
        }
        
    }
    
    func setupNavigationItems(){
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3"), style: .plain, target: self, action: #selector(handleCamera))
    }
    
    @objc func handleCamera(){
        let cameraController = CameraController()
        
        present(cameraController, animated: true, completion: nil)
        
    }
    
    func fetchPosts(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPostWithUser(user: user)
        }
        
    }
    
    func fetchPostWithUser(user: User){
        let ref = Database.database().reference().child("posts").child(user.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            self.collectionView?.refreshControl?.endRefreshing()
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else {return}
                let post = Post(user: user, dictionary: dictionary)
                self.posts.append(post)
                
            })
            self.posts.sort(by: { (p1, p2) -> Bool in
                return p1.timeStamp.compare(p2.timeStamp) == .orderedDescending
            })
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        }) { (err) in
            print("Failed to fetch posts:", err)
        }
        
    }

}

extension HomeController{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomePostCell{
            if posts.count > 0{
                cell.post = posts[indexPath.item]
                 return cell
            }
            
        }
        return UICollectionViewCell()
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 50
        height += 60
        return CGSize(width: view.frame.width, height: height)
    }
    
    
    
    
}
