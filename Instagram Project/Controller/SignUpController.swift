//
//  ViewController.swift
//  Instagram Project
//
//  Created by PoGo on 10/25/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let plusPhotoButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf

    }()
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
        
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
        
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "bg selfie")
        image.contentMode = .scaleAspectFill
        return image
        
        
    }()
    
    let blackAlphaImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.black
        image.alpha = 0.3
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let lineSeparator1: UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return line1
    }()
    
    let lineSeparator2: UIView = {
        let line2 = UIView()
        line2.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return line2
    }()
    
    let lineSeparator3: UIView = {
        let line3 = UIView()
        line3.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return line3
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        button.setAttributedTitle(attributedTitle, for: .normal)
        attributedTitle.append(NSAttributedString(string: "Sign In.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 149/255, green: 204/255, blue: 244/255, alpha: 1)]))
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        view.addSubview(blackAlphaImage)
        view.addSubview(plusPhotoButton)
        view.addSubview(alreadyHaveAccountButton)
        
        blackAlphaImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        if #available(iOS 11.0, *) {
            alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        } else {
            alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        }
        
        setupInputFields()

    }
    
    func setupInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        view.addSubview(lineSeparator1)
        view.addSubview(lineSeparator2)
        view.addSubview(lineSeparator3)
        view.addSubview(signUpButton)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 150)
        
        lineSeparator1.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        
        lineSeparator2.anchor(top: userNameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        
        lineSeparator3.anchor(top: passwordTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        
        signUpButton.anchor(top: lineSeparator3.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
        
    }
  
    @objc func handleTextInputChange() {
        
        let isFormValid = emailTextField.text!.count > 0 && userNameTextField.text!.count > 0 && passwordTextField.text!.count > 0
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .mainBlue()
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    
    
    }
    
    @objc func handleSignup(){
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let username = userNameTextField.text, !username.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failed to create user: ", error)
                return
            }
            
            guard let image = self.plusPhotoButton.imageView?.image else {return}
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            
            guard let userUid = user?.uid else {return}
            
            Storage.storage().reference().child("profile_images").child(userUid).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let error = error{
                    print("Failed to upload profile image:", error)
                    return
                }
                
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else {return}
                
                
                let dictionaryValues = ["username" : username, "profileImageUrl" : profileImageUrl]
                let values = [userUid: dictionaryValues]
                
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        print(error)
                        return
                        
                    }
                    
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                    
                    mainTabBarController.setupViewControllers()
                    
                    self.dismiss(animated: true, completion: nil)
                })

            })
            
            
        }
        
    }
    
    
    @objc func handlePlusPhoto(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
//        let loginController = LoginController()
//        present(loginController, animated: true, completion: nil)
     
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.gray.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        
        
        dismiss(animated: true, completion: nil)
    }

}

