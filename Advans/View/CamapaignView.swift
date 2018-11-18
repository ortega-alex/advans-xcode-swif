//
//  CampaignView.swift
//  Advans
//
//  Created by alex on 18/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class CampaignView: UICollectionViewCell {
    
    var campaign : Campaign? {
        didSet {
            guard let cam = campaign else {return}
            titleLabel.text = cam.name
            fechaLabel.text = cam.creation_date
            for (llamada) in (cam.call_states)! {
                if (llamada.id == 0) {
                    greenButton.setTitle( String(describing : llamada.id), for: .normal)
                    subtitleGreenLabel.text = llamada.name
                    countGreenLabel.text = String(describing : llamada.calls)
                }
                if (llamada.id == 1) {
                    blackButton.setTitle( String(describing : llamada.id), for: .normal)
                    subtitleBlackLabel.text = llamada.name
                    countBlackLabel.text = String(describing :llamada.calls)
                }
                if (llamada.id == 2) {
                    blueButton.setTitle( String(describing : llamada.id), for: .normal)
                    subtitleBlueLabel.text = llamada.name
                    countBlueLabel.text = String(describing :llamada.calls)
                }
                if (llamada.id == 3) {
                    purpleButton.setTitle( String(describing : llamada.id), for: .normal)
                    subtitlePurpleLabel.text = llamada.name
                    countPurpleLabel.text = String(describing :llamada.calls)
                }
                if (llamada.id == 4) {
                    yellowButton.setTitle( String(describing : llamada.id), for: .normal)
                    subtitleYellowLabel.text = llamada.name
                    countYellowLabel.text = String(describing :llamada.calls)
                }
            }
        }
    }
    
    var campaignController : CampaignController? {
        didSet{
            guard let campaniaC = campaignController else { return }
            //greenButton.addTarget(campaniaC, action: #selector(campaniaC.hadleTouchUpInside(_:)), for: .touchUpInside)
            //blackButton.addTarget(campaniaC, action: #selector(campaniaC.hadleTouchUpInside(_:)), for: .touchUpInside)
            //blueButton.addTarget(campaniaC, action: #selector(campaniaC.hadleTouchUpInside(_:)), for: .touchUpInside)
            //purpleButton.addTarget(campaniaC, action: #selector(campaniaC.hadleTouchUpInside(_:)), for: .touchUpInside)
            //yellowButton.addTarget(campaniaC, action: #selector(campaniaC.hadleTouchUpInside(_:)), for: .touchUpInside)
            trashButton.addTarget(campaniaC, action: #selector(campaniaC.hadleDeleteCampania(_:)), for: .touchUpInside)
            addButton.addTarget(campaniaC, action: #selector(campaniaC.hadleAddCampania(_:)), for: .touchUpInside)
        }
    }
    
    var detailCampaignController : DetailCampaignController? {
        didSet{
            guard let detail = detailCampaignController  else { return }
            greenButton.addTarget(detail, action: #selector(detail.hadleTouchUpInside(_:)), for: .touchUpInside)
            blackButton.addTarget(detail, action: #selector(detail.hadleTouchUpInside(_:)), for: .touchUpInside)
            blueButton.addTarget(detail, action: #selector(detail.hadleTouchUpInside(_:)), for: .touchUpInside)
            purpleButton.addTarget(detail, action: #selector(detail.hadleTouchUpInside(_:)), for: .touchUpInside)
            yellowButton.addTarget(detail, action: #selector(detail.hadleTouchUpInside(_:)), for: .touchUpInside)
        }
    }
    
    var campaignSmsController : CampaignSmsController? {
        didSet{
            guard let sms = campaignSmsController else { return }
            greenButton.addTarget(sms, action: #selector(sms.hadleSelectedStatus(_:)), for: .touchUpInside)
            blackButton.addTarget(sms, action: #selector(sms.hadleSelectedStatus(_:)), for: .touchUpInside)
            blueButton.addTarget(sms, action: #selector(sms.hadleSelectedStatus(_:)), for: .touchUpInside)
            purpleButton.addTarget(sms, action: #selector(sms.hadleSelectedStatus(_:)), for: .touchUpInside)
            yellowButton.addTarget(sms, action: #selector(sms.hadleSelectedStatus(_:)), for: .touchUpInside)
        }
    }
    
    let trashButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "trash")
        return btn
    }()
    
    let addButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "add")
        return btn
    }()
    
    private var titleLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Titulo:")
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        return lb
    }()
    
    var fechaLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "232323")
        lb.textAlignment = .center
        return lb
    }()
    
    let greenButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeColor(color: .mainGreen)
        return btn
    }()
    
    private let countGreenLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 20)
        return lb
    }()
    
    private let subtitleGreenLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 10)
        return lb
    }()
    
    let blackButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeColor(color: .mainBlack)
        return btn
    }()
    
    private let countBlackLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 20)
        return lb
    }()
    
    private let subtitleBlackLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 10)
        return lb
    }()
    
    let blueButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeColor(color: .mainBlue)
        return btn
    }()
    
    private let countBlueLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 20)
        return lb
    }()
    
    private let subtitleBlueLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 10)
        return lb
    }()
    
    let purpleButton : UIButton = {
        let button = UIButton(type: .system)
        button.customizeColor(color: .mainPurple)
        return button
    }()
    
    private let countPurpleLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 20)
        return lb
    }()
    
    private let subtitlePurpleLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 10)
        return lb
    }()
    
    let yellowButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeColor(color: .mainYellow)
        return btn
    }()
    
    private let countYellowLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 20)
        return lb
    }()
    
    private let subtitleYellowLabel : UILabel = {
        let lb = UILabel()
        lb.customizeSize(size: 10)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupLayout()
        setupLayoutDetalle()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor ) ,
            addButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 7 ),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor , constant: 10) ,
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 60 ),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -60) ,
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        addSubview(trashButton)
        NSLayoutConstraint.activate([
            trashButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor ) ,
            trashButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -7) ,
            trashButton.widthAnchor.constraint(equalToConstant: 50),
            trashButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        let statusControlsStackView = UIStackView(arrangedSubviews: [greenButton , blackButton , blueButton , purpleButton , yellowButton])
        statusControlsStackView.backgroundColor = .white
        statusControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        //statusControlsStackView.distribution = .fillEqually
        statusControlsStackView.distribution = .fillProportionally
        statusControlsStackView.isLayoutMarginsRelativeArrangement = true
        addSubview(statusControlsStackView)
        
        NSLayoutConstraint.activate([
            statusControlsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor ) ,
            statusControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 7 ),
            statusControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -7) ,
            statusControlsStackView.heightAnchor.constraint(equalToConstant: 65)
            ])
        
        addSubview(fechaLabel)
        //x y h w
        NSLayoutConstraint.activate([
            fechaLabel.topAnchor.constraint(equalTo: statusControlsStackView.bottomAnchor) ,
            fechaLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 10 ),
            fechaLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -10) ,
            fechaLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    private func setupLayoutDetalle(){
        greenButton.addSubview(countGreenLabel)
        NSLayoutConstraint.activate([
            countGreenLabel.leadingAnchor.constraint(equalTo: greenButton.leadingAnchor),
            countGreenLabel.trailingAnchor.constraint(equalTo: greenButton.trailingAnchor),
            countGreenLabel.topAnchor.constraint(equalTo: greenButton.topAnchor , constant : 15),
            countGreenLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        greenButton.addSubview(subtitleGreenLabel)
        NSLayoutConstraint.activate([
            subtitleGreenLabel.leadingAnchor.constraint(equalTo: greenButton.leadingAnchor),
            subtitleGreenLabel.trailingAnchor.constraint(equalTo: greenButton.trailingAnchor),
            subtitleGreenLabel.topAnchor.constraint(equalTo: countGreenLabel.bottomAnchor),
            subtitleGreenLabel.heightAnchor.constraint(equalToConstant: 10)
            ])
        
        blackButton.addSubview(countBlackLabel)
        NSLayoutConstraint.activate([
            countBlackLabel.leadingAnchor.constraint(equalTo: blackButton.leadingAnchor),
            countBlackLabel.trailingAnchor.constraint(equalTo: blackButton.trailingAnchor),
            countBlackLabel.topAnchor.constraint(equalTo: blackButton.topAnchor , constant : 15),
            countBlackLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        blackButton.addSubview(subtitleBlackLabel)
        NSLayoutConstraint.activate([
            subtitleBlackLabel.leadingAnchor.constraint(equalTo: blackButton.leadingAnchor),
            subtitleBlackLabel.trailingAnchor.constraint(equalTo: blackButton.trailingAnchor),
            subtitleBlackLabel.topAnchor.constraint(equalTo: countBlackLabel.bottomAnchor),
            subtitleBlackLabel.heightAnchor.constraint(equalToConstant: 10)
            ])
        
        
        blueButton.addSubview(countBlueLabel)
        NSLayoutConstraint.activate([
            countBlueLabel.leadingAnchor.constraint(equalTo: blueButton.leadingAnchor),
            countBlueLabel.trailingAnchor.constraint(equalTo: blueButton.trailingAnchor),
            countBlueLabel.topAnchor.constraint(equalTo: blueButton.topAnchor , constant : 15),
            countBlueLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        blueButton.addSubview(subtitleBlueLabel)
        NSLayoutConstraint.activate([
            subtitleBlueLabel.leadingAnchor.constraint(equalTo: blueButton.leadingAnchor),
            subtitleBlueLabel.trailingAnchor.constraint(equalTo: blueButton.trailingAnchor),
            subtitleBlueLabel.topAnchor.constraint(equalTo: countBlueLabel.bottomAnchor),
            subtitleBlueLabel.heightAnchor.constraint(equalToConstant: 10)
            ])
        
        purpleButton.addSubview(countPurpleLabel)
        NSLayoutConstraint.activate([
            countPurpleLabel.leadingAnchor.constraint(equalTo: purpleButton.leadingAnchor),
            countPurpleLabel.trailingAnchor.constraint(equalTo: purpleButton.trailingAnchor),
            countPurpleLabel.topAnchor.constraint(equalTo: purpleButton.topAnchor , constant : 15),
            countPurpleLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        purpleButton.addSubview(subtitlePurpleLabel)
        NSLayoutConstraint.activate([
            subtitlePurpleLabel.leadingAnchor.constraint(equalTo: purpleButton.leadingAnchor),
            subtitlePurpleLabel.trailingAnchor.constraint(equalTo: purpleButton.trailingAnchor),
            subtitlePurpleLabel.topAnchor.constraint(equalTo: countPurpleLabel.bottomAnchor),
            subtitlePurpleLabel.heightAnchor.constraint(equalToConstant: 10)
            ])
        
        yellowButton.addSubview(countYellowLabel)
        NSLayoutConstraint.activate([
            countYellowLabel.leadingAnchor.constraint(equalTo: yellowButton.leadingAnchor),
            countYellowLabel.trailingAnchor.constraint(equalTo: yellowButton.trailingAnchor),
            countYellowLabel.topAnchor.constraint(equalTo: yellowButton.topAnchor , constant : 15),
            countYellowLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        yellowButton.addSubview(subtitleYellowLabel)
        NSLayoutConstraint.activate([
            subtitleYellowLabel.leadingAnchor.constraint(equalTo: yellowButton.leadingAnchor),
            subtitleYellowLabel.trailingAnchor.constraint(equalTo: yellowButton.trailingAnchor),
            subtitleYellowLabel.topAnchor.constraint(equalTo: countYellowLabel.bottomAnchor),
            subtitleYellowLabel.heightAnchor.constraint(equalToConstant: 10)
            ])
    }
}
