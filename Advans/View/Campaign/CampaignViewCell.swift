//
//  CampaignViewCell.swift
//  Advans
//
//  Created by alex on 17/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class CampaignViewCell: UICollectionViewCell {
    
    var index : Int? {
        didSet{
            guard let i = index else { return }
            deleteButton.tag = i
            addButton.tag = i
        }
    }
    var campaign : Campaign? {
        didSet{
            guard let camp = campaign else { return }
            titleLabel.text = camp.name
            dateLabel.text = camp.creation_date
            self.call_states = camp.call_states!
            if ( campaign?.type == "A") {
                addButton.isHidden = true
            }
        }
    }
    var call_states = [Call_state]()
    
    var campaignController : CampaignController? {
        didSet{
            guard let campaignCon = campaignController else { print("vacio"); return }
            deleteButton.addTarget(campaignCon, action: #selector(campaignCon.hadleDeleteCampania(_:)), for: .touchUpInside)
            addButton.addTarget(campaignCon, action: #selector(campaignCon.hadleAddCampania(_:)), for: .touchUpInside)
        }
    }
    
    private let deleteButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "trash")
        return btn
    }()
    
    private let addButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "add")
        return btn
    }()
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "")
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        return lb
    }()
    
    private let dateLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "")
        lb.textAlignment = .center
        return lb
    }()
    
    let collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let cellId = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(CampaignStatusViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        addSubview(addButton)
        addSubview(titleLabel)
        addSubview(deleteButton)
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor ) ,
            addButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 7 ),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor , constant: 10) ,
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant: 60 ),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -60) ,
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor ) ,
            deleteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant: -7) ,
            deleteButton.widthAnchor.constraint(equalToConstant: 50),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: deleteButton.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant : 7),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant : -7),
            collectionView.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant : 7),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant : -7),
            dateLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
    }
    
    @objc func handleButtonStatus(_ button: UIButton){
        print("index" , deleteButton.tag  ,  "status" , button.tag)
        //self.campaignController?.hadleStatusCampaign(self.deleteButton , id_status: button.tag)
        for row in call_states.indices {
            if (row == button.tag) {
                call_states[row].selectd = true
            } else {
                call_states[row].selectd = false
            }
        }
        let sections = IndexSet.init(integer: 0)
        collectionView.reloadSections(sections)
    }
}
