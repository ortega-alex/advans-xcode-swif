//
//  CampaignSmsController.swift
//  Advans
//
//  Created by alex on 3/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CampaignSmsController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    private lazy var  managerButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .black, text: "SMS MANAGER")
        btn.addTarget(self, action: #selector(hadleManager), for: .touchUpInside)
        return btn
    }()
    private let global = Global()
    var campaigns = [Campaign]()
    
    private lazy var  cancelButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .black, text: "CANCEL")
        btn.addTarget(self, action: #selector(hadleCancel), for: .touchUpInside)
        return btn
    }()
    
    private lazy var createButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .black, text: "CREATE")
        btn.addTarget(self, action: #selector(hadleCreate), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(CampaignView.self , forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        collectionView?.isPagingEnabled = true
        
        // collectionView.backgroundColor = .mainLightGray
        collectionView.backgroundColor = .lightGray
        
        setupLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CampaignView
        let campaign = campaigns[indexPath.row]
        cell.campaign = campaign
        cell.campaignSmsController = self
        if (campaign.type == "M") {
            cell.greenButton.isHidden = true
        }
        cell.addButton.isHidden = true
        cell.trashButton.isHidden = true
        
        cell.greenButton.tag = indexPath.row
        cell.greenButton.layer.borderColor = UIColor.lightGray.cgColor
        cell.blackButton.tag = indexPath.row
        cell.blackButton.layer.borderColor = UIColor.lightGray.cgColor
        cell.blueButton.tag = indexPath.row
        cell.blueButton.layer.borderColor = UIColor.lightGray.cgColor
        cell.purpleButton.tag = indexPath.row
        cell.purpleButton.layer.borderColor = UIColor.lightGray.cgColor
        cell.yellowButton.tag = indexPath.row
        cell.yellowButton.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.backgroundColor = .lightGray
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        header.backgroundColor = .lightGray
        header.addSubview(managerButton)
        NSLayoutConstraint.activate([
            managerButton.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor),
            managerButton.trailingAnchor.constraint(equalTo: header.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            managerButton.leadingAnchor.constraint(equalTo: header.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            managerButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    fileprivate func setupLayout(){
        collectionView.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor),
            //cancelButton.trailingAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            cancelButton.rightAnchor.constraint(equalTo: collectionView.centerXAnchor, constant: -2),
            cancelButton.leadingAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        collectionView.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor),
            createButton.trailingAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            createButton.leftAnchor.constraint(equalTo: collectionView.centerXAnchor, constant: 2),
            //createButton.leadingAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.leadingAnchor, constant: -10),
            createButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
   
    
    @objc private func hadleManager(){
        let smsManagerController = SmsManagerController()
        let navigateController = UINavigationController(rootViewController: smsManagerController)
        self.present(navigateController, animated: true, completion: nil)
    }
    
    @objc private func hadleCancel(){
        let campaignController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigateController = UINavigationController(rootViewController: campaignController)
        self.present(navigateController, animated: true, completion: nil)
    }
    
    @objc private func hadleCreate(){
        let newCampaignSmsController = NewCampaignSmsController(collectionViewLayout: UICollectionViewFlowLayout())
        newCampaignSmsController.campaigns = self.campaigns
        let navigateController = UINavigationController(rootViewController: newCampaignSmsController)
        self.present(navigateController, animated: true, completion: nil)
    }
    
    @objc func hadleSelectedStatus(_ button: UIButton){
        print(button.layer.borderColor == UIColor.lightGray.cgColor)
        if button.layer.borderColor == UIColor.lightGray.cgColor {
            button.layer.borderColor = UIColor.white.cgColor
            self.campaigns[button.tag].call_states![Int((button.titleLabel?.text)!)!].selectd = true
        } else {
            button.layer.borderColor = UIColor.lightGray.cgColor
            self.campaigns[button.tag].call_states![Int((button.titleLabel?.text)!)!].selectd = false
        }
        print("TouchUpInside id_stado: " , button.tag , "id_campania: " , button.titleLabel?.text as Any , self.campaigns[button.tag].call_states![Int((button.titleLabel?.text)!)!].selectd as Any )
    }
}
