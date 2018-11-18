//
//  CampaignStatusViewCell.swift
//  Advans
//
//  Created by alex on 17/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class CampaignStatusViewCell : UICollectionViewCell {
    
    private let colores : [UIColor] = [ .mainGreen , .mainBlack , .mainBlue , .mainPurple , .mainYellow ]
    var call_state : Call_state? {
        didSet{
            guard let state = call_state else { return }
            statusButton.tag = state.id
            statusButton.customizeColor(color: colores[state.id])
            subtitleLabel.text = state.name
            countLabel.text = String(describing : state.calls)
        }
    }
    
    var campaignController : CampaignController? {
        didSet{
            guard let campaignCon = campaignController else { return }
            statusButton.addTarget(campaignCon, action: #selector(campaignCon.hadleTouchUpInside(_:)), for: .touchUpInside)
        }
    }
    
    var campaignViewCell : CampaignViewCell? {
        didSet{
            statusButton.addTarget(campaignViewCell, action: #selector(campaignViewCell?.handleButtonStatus(_:)), for: .touchUpInside)
        }
    }
    
    let statusButton : UIButton = {
        let btn = UIButton(type: .system)
        //btn.customizeColor(color: .mainGreen)
        return btn
    }()
    
    private let countLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 20)
        return lb
    }()
    
    private let subtitleLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 10)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupLayout(){
        addSubview(statusButton)
        NSLayoutConstraint.activate([
            statusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusButton.widthAnchor.constraint(equalTo: widthAnchor),
            statusButton.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        statusButton.addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: statusButton.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: statusButton.trailingAnchor),
            countLabel.topAnchor.constraint(equalTo: statusButton.topAnchor , constant : 15),
            countLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        statusButton.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: statusButton.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: statusButton.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}

