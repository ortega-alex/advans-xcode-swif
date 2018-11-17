//
//  RegisterView.swift
//  Advans
//
//  Created by alex on 8/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import DownPicker

class RegisterView : UICollectionViewCell {
    
    var registerDownPicker: DownPicker!
    var register : Register? {
        didSet {
            guard let unwrappedRegister = register else {return}
            if ((unwrappedRegister.id) == 0)  {
                optionTextField.isHidden = false
                textField.isHidden = true
                let idioma: NSMutableArray = ["Espanol", "Ingles"]
                self.registerDownPicker = DownPicker(textField: self.optionTextField, withData:idioma as? [Any])
                optionTextField.placeholder = unwrappedRegister.placeholder
                optionTextField.text = unwrappedRegister.value
                optionTextField.textAlignment = .center
            } else {
                optionTextField.isHidden = true
                textField.isHidden = false
                textField.placeholder = unwrappedRegister.placeholder
                textField.text = unwrappedRegister.value
                textField.textAlignment = .center
            }
            if (unwrappedRegister.id == 3){
                textField.isSecureTextEntry = true
            } else {
                textField.isSecureTextEntry = false
            }
        }
    }
    
    var registerController : RegisterController? {
        didSet {
            textField.addTarget(registerController, action: #selector(registerController?.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            registerController?.registers[0].value = optionTextField.text ?? ""
        }
    }
    
    private let textField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let optionTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
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
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        addSubview(textField)
        //x,y,h,w
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor) ,
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            textField.rightAnchor.constraint(equalTo: rightAnchor  ,constant: -24) ,
            textField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(optionTextField)
        //x,y,h,w
        NSLayoutConstraint.activate([
            optionTextField.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor) ,
            optionTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            optionTextField.rightAnchor.constraint(equalTo: rightAnchor  ,constant: -24) ,
            optionTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
