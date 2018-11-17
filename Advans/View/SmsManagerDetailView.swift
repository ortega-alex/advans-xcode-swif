//
//  SmsManagerDetailView.swift
//  Advans
//
//  Created by alex on 12/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class SmsManagerDetailView : UITableViewCell {
    
    var campaing : CampaignSmsDecodable? {
        didSet{
            guard let c  = campaing else { return }
            textareaTextView.text = c.sms_text
        }
    }
    
    var smsManagerController : SmsManagerController? {
        didSet{
            linkButon.addTarget(smsManagerController, action: #selector(smsManagerController?.handleLink(_:)), for: .touchUpInside)
            playButton.addTarget(smsManagerController, action: #selector(smsManagerController?.handlePlay(_:)), for: .touchUpInside)
            deleteButton.addTarget(smsManagerController, action: #selector(smsManagerController?.handleDelete(_:)), for: .touchUpInside)
        }
    }
    
    let linkButon : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .black, text: "LINK")
        return btn
    }()
    
    let deleteButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "trash")
        return btn
    }()
    
    let playButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "play")
        return btn
    }()
    
    private let textareaTextView : UITextView = {
        let tv = UITextView()
        tv.customize()
        tv.placeholderColor = .lightGray
        tv.placeholder = "Edit this text message and it will be sent to each lead 'No Answer' after you called. Write *name* where you want each of the customers name on the text"
        return tv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        //impide que quede seleccionada la celda 
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
    
        let statusControlsStackView = UIStackView(arrangedSubviews: [linkButon , deleteButton , playButton])
        statusControlsStackView.backgroundColor = .white
        statusControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        statusControlsStackView.distribution = .fillProportionally
        statusControlsStackView.isLayoutMarginsRelativeArrangement = true
    
        addSubview(statusControlsStackView)
        addSubview(textareaTextView)
        NSLayoutConstraint.activate([
            textareaTextView.topAnchor.constraint(equalTo: topAnchor , constant : 5),
            textareaTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textareaTextView.widthAnchor.constraint(equalTo: widthAnchor , constant : -10),
            textareaTextView.heightAnchor.constraint(equalToConstant: 60),
            statusControlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor , constant : 3),
            statusControlsStackView.widthAnchor.constraint(equalTo: widthAnchor),
            statusControlsStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
