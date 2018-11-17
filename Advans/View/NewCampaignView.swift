//
//  NewCampaignView.swift
//  Advans
//
//  Created by alex on 25/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class NewCampaignView: UIView {
    
    var newCampaignController : NewCampaignController? {
        didSet {
            archiveButton.addTarget(newCampaignController, action: #selector(newCampaignController?.hadleInserArchive), for: .touchUpInside)
            createButton.addTarget(newCampaignController, action: #selector(newCampaignController?.hadleCreate), for: .touchUpInside)
        }
    }
    
    private let descriptionTextView : UITextView = {
        let tv = UITextView()
        let at = NSMutableAttributedString(string: "Nueva campania desde un archivo", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        at.append(NSAttributedString(string: "\n\n\nSuba su archivo, asegurese de tener sus encabezados en la primera line como en este ejemplo.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16) , NSAttributedString.Key.foregroundColor : UIColor.black]))
        tv.backgroundColor = .clear
        tv.attributedText = at
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textAlignment = .center
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    private let imagenView : UIImageView = {
        let image = UIImageView()
        let img = UIImage(named: "dragon")
        image.image = img
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let archiveButton : UIButton = {
        let button = UIButton(type: .system)
        button.customize(color: .black, text: "SUBIR ARCHIVO XLS / CSV")
        return button
    }()
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 20)
        lb.text = "Nueva campania manual"
        lb.textColor = .black
        return lb
    }()
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.placeholder = "Nombew de la camapania"
        return tf
    }()
    
    private let createButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color : .black, text: "CREATE")
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        addSubview(descriptionTextView)
        //x y h w
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: topAnchor , constant: 5) ,
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            descriptionTextView.heightAnchor.constraint(equalToConstant: 250)
            ])
        
        addSubview(imagenView)
        //x y h w
        NSLayoutConstraint.activate([
            imagenView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 5) ,
            imagenView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            imagenView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            imagenView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        addSubview(archiveButton)
        //x y h w
        NSLayoutConstraint.activate([
            archiveButton.topAnchor.constraint(equalTo: imagenView.bottomAnchor, constant: 5) ,
            archiveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            archiveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            archiveButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(titleLabel)
        //x y h w
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: archiveButton.bottomAnchor, constant: 30) ,
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(nameTextField)
        //x y h w
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5) ,
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(createButton)
        //x y h w
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5) ,
            createButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            createButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            createButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}

