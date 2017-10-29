//
//  LoginController.swift
//  Instagram Project
//
//  Created by PoGo on 10/27/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let logoImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "instagram-logo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let signUpButton: UIButton = {
       let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        button.setAttributedTitle(attributedTitle, for: .normal)
        attributedTitle.append(NSAttributedString(string: "Sign Up.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 149/255, green: 204/255, blue: 244/255, alpha: 1)]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
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
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(backgroundImage)
        view.addSubview(blackAlphaImage)
        view.addSubview(logoImage)
        view.addSubview(signUpButton)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        
        
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blackAlphaImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        setupInputFields()
        
        
    }
    
    func setupInputFields(){
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        
        view.addSubview(stackView)
        view.addSubview(lineSeparator1)
        view.addSubview(lineSeparator2)
        view.addSubview(loginButton)
        
        stackView.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 80, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 100)
        
        lineSeparator1.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        lineSeparator2.anchor(top: passwordTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 1)
        loginButton.anchor(top: lineSeparator2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
        
        
        
    }
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error{
                print("Failed to sign in:", err)
                return
            }
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}

            mainTabBarController.setupViewControllers()
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    
    @objc func handleTextInputChange(){
        
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .mainBlue()
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
        
    }
    
    @objc func handleShowSignUp(){
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
        
    }

    @objc func endEditing(){
        view.endEditing(true)
    }

}
