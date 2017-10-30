//
//  LoginOrSignUpController.swift
//  Instagram Project
//
//  Created by PoGo on 10/27/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class LoginOrSignUpController: UIViewController {
    
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.purple
        return button

    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.purple
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
    }



}
