//
//  TempController.swift
//  Advans
//
//  Created by alex on 16/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TempController: UICollectionViewController {
    
    private let global = Global()
    private let cellId = "cellId"
    var campaigns : [Campaign] = [
        Campaign( _id : "235252" , name : "My Campaign" , type : "A" , creation_date : "31/05/2018" , call_states : [
            Call_state(  _id : "38" , id  : 0 , name:  "archivos" , calls : 10 , selectd : false ),
            Call_state(  _id : "39" , id  : 1 , name:  "no llamar" , calls : 1 , selectd : false ),
            Call_state(  _id : "40" , id  : 2 , name:  "no volver a llamar" , calls : 0 , selectd : false ),
            Call_state(  _id : "41" , id  : 3 , name:  "no contesto" , calls : 12 , selectd : false ),
            Call_state(  _id : "42" , id  : 4 , name:  "vendido" , calls : 5 , selectd : false )
        ]) ,
        Campaign( _id : "6525152" , name : "My Campaign2" , type : "A" , creation_date : "31/05/2018" , call_states : [
            Call_state(  _id : "43" , id  : 0 , name:  "archivos" , calls : 110 , selectd : false ),
            Call_state(  _id : "44" , id  : 1 , name:  "no llamar" , calls : 0 , selectd : false ),
            Call_state(  _id : "45" , id  : 2 , name:  "no volver a llamar" , calls : 0 , selectd : false ),
            Call_state(  _id : "46" , id  : 3 , name:  "no contesto" , calls : 0 , selectd : false ),
            Call_state(  _id : "47" , id  : 4 , name:  "vendido" , calls : 0 , selectd : false )
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TempViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .purple
    }
    
    @objc func hadleDeleteCampaign(_ button: UIButton){
        print("delete" , button.tag , self.campaigns[button.tag].name as Any)
    }
    
    @objc func hadleAddCampaign(_ button: UIButton){
        print("add" , button.tag , self.campaigns[button.tag].name as Any)
    }
    
    @objc func hadleStatusCampaign(_ button: UIButton , id_status : Int ){
        print("Campania" , self.campaigns[button.tag]._id as Any , "Status" , id_status  )
    }
}

extension TempController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TempViewCell
        cell.tempController = self
        cell.backgroundColor = .white
        cell.campaign = self.campaigns[indexPath.row]
        cell.addButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.campaigns.count
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 135)
    }
}

class TempViewCell : UICollectionViewCell {
    
    var campaign : Campaign? {
        didSet{
            guard let camp = campaign else { return }
            titleLabel.text = camp.name
            dateLabel.text = camp.creation_date
            self.call_states = camp.call_states!
        }
    }
    var call_states = [Call_state]()
    var index : Int = 0
    
    var tempController : TempController? {
        didSet{
            guard let temp = tempController else { return }
            deleteButton.addTarget(temp, action: #selector(temp.hadleDeleteCampaign(_:)), for: .touchUpInside)
            addButton.addTarget(temp, action: #selector(temp.hadleAddCampaign(_:)), for: .touchUpInside)
        }
    }
    
    let deleteButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon: "trash")
        return btn
    }()
    
    let addButton : UIButton = {
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
        collectionView.register(TempViewButtonCell.self, forCellWithReuseIdentifier: cellId)
        
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
        self.tempController?.hadleStatusCampaign(self.deleteButton , id_status: button.tag)
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

extension TempViewCell : UICollectionViewDataSource , UICollectionViewDelegate  , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return call_states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TempViewButtonCell
        cell.tempViewCell = self
        cell.backgroundColor = .white
        //print("TempViewButtonCell" , indexPath.row , indexPath.section)
        cell.call_state = call_states[indexPath.row]
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

class TempViewButtonCell : UICollectionViewCell {
    
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
    
    var tempViewCell : TempViewCell? {
        didSet{
            statusButton.addTarget(tempViewCell, action: #selector(tempViewCell?.handleButtonStatus(_:)), for: .touchUpInside)
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
