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
    
    private let collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    private let cellId = "cell"
    
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

extension CampaignViewCell : UICollectionViewDataSource , UICollectionViewDelegate  , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return call_states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CampaignStatusViewCell
        cell.campaignViewCell = self
        cell.campaignController = self.campaignController
        cell.backgroundColor = .white
        cell.call_state = call_states[indexPath.row]
        cell.statusButton.setTitle( campaign?._id , for: .normal)
        if (call_states[indexPath.row].selectd == nil || call_states[indexPath.row].selectd == false){
            cell.statusButton.layer.borderColor = UIColor.white.cgColor
        } else {
            cell.statusButton.layer.borderColor = UIColor.red.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(call_states.count)
        return CGSize(width: width , height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

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
