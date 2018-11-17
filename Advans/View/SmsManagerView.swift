//
//  SmsManagerView.swift
//  advanSales
//
//  Created by alex on 7/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class SmsManagerView : UITableViewCell {
    
    var campaing : CampaignSmsDecodable? {
        didSet {
            guard let c = campaing else { return }
            nameLabel.text = c.name
            let at = NSMutableAttributedString(string: "Stard date: ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            at.append(NSAttributedString(string: c.start_date! , attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16) , NSAttributedString.Key.foregroundColor : UIColor.black]))
            dateTextView.attributedText = at
            dateTextView.textAlignment = .center
            
            let at1 = NSMutableAttributedString(string: "Status: ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            at1.append(NSAttributedString(string: (c.status == nil) ? "Configurate" : "Activa" , attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16) , NSAttributedString.Key.foregroundColor : UIColor.black]))
            statusTextView.attributedText = at1
            statusTextView.textAlignment = .center
        }
    }
    
    var smsManagerController : SmsManagerController? {
        didSet{
            ampliarButton.addTarget(smsManagerController, action: #selector(smsManagerController?.handleExpandClose(_:)), for: .touchUpInside)
        }
    }
    
    private let nameLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Mi campaign")
        lb.textAlignment = .center
        return lb
    }()
    
    private let dateTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    private let statusTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let ampliarButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "ampliar")
        return btn
    }()
    
    private let progressLabel : UILabel = {
        let lb = UILabel()
        let int = 0.9
        lb.text = "\(int * 100)" + "%"
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = .white
        lb.backgroundColor = .black
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let progressBar : UIProgressView  =  {
        let pg = UIProgressView(progressViewStyle: .bar)
        pg.progress = 0.9
        pg.progressTintColor = .black
        pg.trackTintColor = .white
        pg.translatesAutoresizingMaskIntoConstraints = false
        return pg
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        addSubview(nameLabel)
        addSubview(dateTextView)
        addSubview(statusTextView)
        addSubview(ampliarButton)
        addSubview(progressLabel)
        addSubview(progressBar)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor , constant: 5) ,
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 16) ,
            dateTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            dateTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            dateTextView.heightAnchor.constraint(equalToConstant: 25),
            
            ampliarButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            ampliarButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            ampliarButton.widthAnchor.constraint(equalToConstant: 30),
            ampliarButton.heightAnchor.constraint(equalToConstant: 30),
            
            statusTextView.topAnchor.constraint(equalTo: dateTextView.bottomAnchor, constant: 1),
            statusTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            statusTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            statusTextView.heightAnchor.constraint(equalToConstant: 30),
            
            progressLabel.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 1),
            progressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            progressLabel.widthAnchor.constraint(equalToConstant: 70),
            progressLabel.heightAnchor.constraint(equalToConstant: 16),
            
            progressBar.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 1),
            progressBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 80),
            progressBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            progressBar.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}

