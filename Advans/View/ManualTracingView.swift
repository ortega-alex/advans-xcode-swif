//
//  ManualTracingView.swift
//  Advans
//
//  Created by alex on 31/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class ManualTracingView: UICollectionViewCell {
    
    var call : Call? {
        didSet{
            guard let c = call else { return }
            campaignNameTextField.text = c.name
            field0TextField.text = c.field1
            field1TextField.text = c.field2
        }
    }
    
    private let campaignNameLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Campaing name:")
        return lb
    }()
    
    private let campaignNameTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private let nameLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "name:")
        return lb
    }()
    
    private let nameTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let field0Label : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Field 1:")
        return lb
    }()
    
    private let field0TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let field1Label : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Field 2:")
        return lb
    }()
    
    private let field1TextField : UITextField = {
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
    
    fileprivate func  setupLayout(){
        addSubview(campaignNameLabel)
        NSLayoutConstraint.activate([
            campaignNameLabel.topAnchor.constraint(equalTo: topAnchor),
            campaignNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            campaignNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            campaignNameLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(campaignNameTextField)
        NSLayoutConstraint.activate([
            campaignNameTextField.topAnchor.constraint(equalTo: campaignNameLabel.bottomAnchor, constant: 1),
            campaignNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            campaignNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            campaignNameTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: campaignNameTextField.bottomAnchor, constant: 1),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            nameLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(field0Label)
        NSLayoutConstraint.activate([
            field0Label.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 1),
            field0Label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field0Label.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2),
            field0Label.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(field1Label)
        NSLayoutConstraint.activate([
            field1Label.topAnchor.constraint(equalTo: nameTextField.bottomAnchor , constant : 1),
            field1Label.leadingAnchor.constraint(equalTo: field0Label.trailingAnchor , constant : 2),
            field1Label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            field1Label.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(field0TextField)
        NSLayoutConstraint.activate([
            field0TextField.topAnchor.constraint(equalTo: field1Label.bottomAnchor, constant: 1),
            field0TextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field0TextField.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2),
            field0TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(field1TextField)
        NSLayoutConstraint.activate([
            field1TextField.topAnchor.constraint(equalTo: field1Label.bottomAnchor , constant : 1),
            field1TextField.leadingAnchor.constraint(equalTo: field0TextField.trailingAnchor , constant : 2),
            field1TextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            field1TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
}

