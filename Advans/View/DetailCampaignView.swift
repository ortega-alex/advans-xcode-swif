//
//  DetailCampagnView.swift
//  Advans
//
//  Created by alex on 1/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class DetailCampaignView: UICollectionViewCell {
    var call : Call? {
        didSet{
            guard let c = call else { return }
            callButton.setTitle(c.name! + "\n" + c.phone! , for: .normal)
        }
    }
    
    var detailCampaignController : DetailCampaignController? {
        didSet{
            guard let detail = detailCampaignController else { return }
            editButton.addTarget(detail, action: #selector(detail.hadleEdit(_:)), for: .touchUpInside)
            noteButton.addTarget(detail, action: #selector(detail.hadleNote(_:)), for: .touchUpInside)
            callButton.addTarget(detail, action: #selector(detail.hadleCall(_:)), for: .touchUpInside)
        }
    }
    
    let editButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .white, text: "Edit")
        btn.preservesSuperviewLayoutMargins = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.tintColor = .black
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let noteButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .white, text: "Note")
        btn.preservesSuperviewLayoutMargins = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.tintColor = .black
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let callButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .white, text: "phone")
        btn.preservesSuperviewLayoutMargins = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.tintColor = .black
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setuptLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setuptLayout(){
        let statusControlsStackView = UIStackView(arrangedSubviews: [editButton  , noteButton , callButton])
        statusControlsStackView.backgroundColor = .white
        statusControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        statusControlsStackView.distribution = .fillProportionally
        statusControlsStackView.spacing = 5
        addSubview(statusControlsStackView)
        
        NSLayoutConstraint.activate([
            statusControlsStackView.topAnchor.constraint(equalTo: topAnchor) ,
            statusControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 7 ),
            statusControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -7) ,
            statusControlsStackView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
}
