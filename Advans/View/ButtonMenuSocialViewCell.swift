//
//  ButtonMenuSocialViewCell.swift
//  Advans
//
//  Created by alex on 15/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class ButtonMenuSocialViewCell: UICollectionViewCell {
    
    lazy var button : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.mainLightGray.cgColor
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor) ,
            button.centerYAnchor.constraint(equalTo: centerYAnchor) ,
            button.widthAnchor.constraint(equalTo: widthAnchor, constant: -4),
            button.heightAnchor.constraint(equalTo: heightAnchor, constant: -4)
        ])
    }
}
