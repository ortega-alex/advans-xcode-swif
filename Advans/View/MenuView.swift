//
//  MenuView.swift
//  Adcans
//
//  Created by alex on 24/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class MenuView: UICollectionViewCell {
    
    var menu : Menu? {
        didSet{
            guard let m = menu else {return}
            logoImageView.image = UIImage(named: m.logoName)
            titleLabel.text = m.text
            btnMenuButton.tag = m.id
            if m.color == "g" {
                btnMenuButton.backgroundColor = .mainGreen
            }
            if m.color == "b" {
                btnMenuButton.backgroundColor = .mainBlack
            }
            if m.color == "bl" {
                btnMenuButton.backgroundColor = .mainBlue
            }
            if m.color == "p" {
                btnMenuButton.backgroundColor = .mainPurple
            }
            if m.color == "y" {
                btnMenuButton.backgroundColor = .mainYellow
            }
        }
    }
    
    var menuController : MenuController? {
        didSet{
            btnMenuButton.addTarget(menuController, action: #selector(menuController?.hadleMenuSelected(_:)), for: .touchUpInside)
        }
    }
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 16)
        return lb
    }()
    
    private let btnMenuButton : UIButton = {
        let btn = UIButton()
        btn.customizeColor(color: .white)
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
        addSubview(btnMenuButton)
        //x y w h
        NSLayoutConstraint.activate([
            //view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor ) ,
            btnMenuButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            btnMenuButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            btnMenuButton.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        
        btnMenuButton.addSubview(logoImageView)
        //x y w h
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: btnMenuButton.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: btnMenuButton.centerYAnchor , constant : -20 ),
            logoImageView.widthAnchor.constraint(equalToConstant: 80) ,
            logoImageView.heightAnchor.constraint(equalToConstant: 80)
            ])
        
        btnMenuButton.addSubview(titleLabel)
        
        //x y w h
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor , constant : 5) ,
            titleLabel.centerXAnchor.constraint(equalTo: btnMenuButton.centerXAnchor) ,
            titleLabel.widthAnchor.constraint(equalTo: btnMenuButton.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
    }
}

