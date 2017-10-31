//
//  UserSearchController.swift
//  Instagram Project
//
//  Created by PoGo on 10/31/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    var users = [User]()
    var filteredUsers = [User]()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        sb.delegate = self
        return sb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(UserSearchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        fetchUsers()
    }
    
    private func fetchUsers(){
        
        let ref = Database.database().reference().child("users")
        ref.observe(.value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach({ (key,value) in
                guard let userDictionary = value as? [String: Any] else {return}
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
            })
            
            self.users.sort(by: { (user1, user2) -> Bool in
                return user1.userName.compare(user2.userName) == .orderedAscending
            })
            self.filteredUsers = self.users
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed",error)
        }
    
    
    
    }


}
extension UserSearchController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UserSearchCell{
            cell.user = filteredUsers[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
    
}

extension UserSearchController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredUsers = users
        }else{
            filteredUsers = self.users.filter { (user) -> Bool in
                return user.userName.lowercased().contains(searchText.lowercased())
            }
        }
        
        self.collectionView?.reloadData()
       
    }
    
    
    
}
