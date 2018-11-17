//
//  LoginView.swift
//  Advans
//
//  Created by alex on 8/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class LoginView : UIView {
    
    var loginController : LoginController? {
        didSet {
            loginButton.addTarget(loginController, action: #selector(loginController?.hadleLogin), for: .touchUpInside)
            registerButton.addTarget(loginController, action: #selector(loginController?.hadleRegister), for: .touchUpInside)
        }
    }
    
    private let logoImageView : UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let addressTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.placeholder = "User Name"
        tf.backgroundColor = .white
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.placeholder = "Password"
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .white, text: "LOGIN")
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var registerButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .white, text: "REGISTER")
        btn.tintColor = .black
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .black
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        topImageContainerView.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor) ,
            logoImageView.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 12),
            logoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.6) ,
            logoImageView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.6)
            ])
        
        addSubview(addressTextField)
        //x,y,h,w
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor) ,
            addressTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            addressTextField.rightAnchor.constraint(equalTo: rightAnchor  ,constant: -24) ,
            addressTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(passwordTextField)
        //x,y,h,w
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor , constant: 12 ) ,
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor  ,constant: -24) ,
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(loginButton)
        //x,y,h,w
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor , constant: 12 ) ,
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor  ,constant: -24) ,
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(registerButton)
        //x,y,h,w
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor , constant: 12 ) ,
            registerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            registerButton.rightAnchor.constraint(equalTo: rightAnchor  ,constant: -24) ,
            registerButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
