//
//  NewCampaignSmsController.swift
//  Advans
//
//  Created by alex on 6/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewCampaignSmsController : UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let footerId = "footerId"
    var campaigns = [Campaign]()
    var campaignSms = CampaignSms()
    private let global = Global()
    
    private lazy var sendButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .black, text: "SEND")
        btn.addTarget(self, action: #selector(handleSendCamapaign), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        campaignSms.calls = []
        
        collectionView.register(NewCampaignSmsView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        collectionView.register(CampaignView.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter , withReuseIdentifier: footerId)
        collectionView?.isPagingEnabled = true
        
        let addImage = UIImage(named : "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(hadkeBack))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        //fuerza el color det titulo
        navigationItem.title = "NEW CAMPAIGN SMS"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //line que divide el nav con el view
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationController?.navigationBar.tintColor = .black
        collectionView.backgroundColor = .white
        
    }
    
    @objc private func hadkeBack(){
        let campaignController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigateController = UINavigationController(rootViewController: campaignController)
        self.present(navigateController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! NewCampaignSmsView
            header.newCampaignSmsController = self
            header.backgroundColor = .white
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            footer.backgroundColor = .white
            footer.addSubview(sendButton)
            NSLayoutConstraint.activate([
                sendButton.topAnchor.constraint(equalTo: footer.topAnchor),
                sendButton.leadingAnchor.constraint(equalTo: footer.leadingAnchor , constant : 10),
                sendButton.trailingAnchor.constraint(equalTo: footer.trailingAnchor , constant : -10) ,
                sendButton.heightAnchor.constraint(equalTo: footer.heightAnchor)
                ])
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 335)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CampaignView
        
        cell.addButton.isHidden = true
        cell.trashButton.isHidden = true
        cell.fechaLabel.isHidden = true
        
        /*cell.blueButton.isHidden = true
         cell.blackButton.isHidden = true
         cell.greenButton.isHidden = true
         cell.purpleButton.isHidden = true
         cell.yellowButton.isHidden = true*/
        
        cell.blueButton.backgroundColor = .white
        cell.blueButton.tintColor = .white
        cell.blackButton.backgroundColor = .white
        cell.blackButton.tintColor = .white
        cell.greenButton.backgroundColor = .white
        cell.greenButton.tintColor = .white
        cell.purpleButton.backgroundColor = .white
        cell.purpleButton.tintColor = .white
        cell.yellowButton.backgroundColor = .white
        cell.yellowButton.tintColor = .white
        
        let campaing = self.campaigns[indexPath.item]
        
        for state in campaing.call_states! {
            if (state.id == 0 && state.selectd == true) {
                //cell.greenButton.isHidden = false
                cell.greenButton.backgroundColor = .mainGreen
                cell.greenButton.tintColor = .mainGreen
                if let text = state._id {
                    campaignSms.calls!.append(text)
                }
            }
            if (state.id == 1 && state.selectd == true) {
                //cell.blackButton.isHidden = false
                cell.blackButton.backgroundColor = .mainBlack
                cell.blackButton.tintColor = .mainBlack
                if let text = state._id {
                    campaignSms.calls!.append(text)
                }
            }
            if (state.id == 2 && state.selectd == true) {
                //cell.blueButton.isHidden = false
                cell.blueButton.backgroundColor = .mainBlack
                cell.blueButton.tintColor = .mainBlack
                if let text = state._id {
                    campaignSms.calls!.append(text)
                }
            }
            if (state.id == 3 && state.selectd == true) {
                //cell.purpleButton.isHidden = false
                cell.purpleButton.backgroundColor = .mainPurple
                cell.purpleButton.tintColor = .mainPurple
                if let text = state._id {
                    campaignSms.calls!.append(text)
                }
            }
            if (state.id == 4 && state.selectd == true) {
                //cell.yellowButton.isHidden = false
                cell.yellowButton.backgroundColor = .mainYellow
                cell.yellowButton.tintColor = .mainYellow
                if let text = state._id {
                    campaignSms.calls!.append(text)
                }
            }
        }
        cell.campaign = campaing
        cell.backgroundColor = .white
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 115)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 50)
    }
    
    @objc private func handleSendCamapaign(){
        guard let id = User.get.id else { return }
        DispatchQueue.main.async{
            do {
                let url : String = self.global.URL + "sms/" + id
                let data = try JSONEncoder().encode(self.campaignSms)
                let params : Parameters = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Parameters
                Alamofire.request(
                    url ,
                    method: .post  ,
                    parameters: params ,
                    encoding: JSONEncoding.default ,
                    headers: self.global.HEADERS
                    ).responseJSON(completionHandler: { (response) in
                        switch response.result{
                        case .success(let value):
                            let json = JSON(value)
                            if ( json["status"].stringValue == "success" ) {
                                self.handleSmsManager()
                            } else {
                                let myAlert = self.global.alert(title: "msj", message: json["msj"].stringValue ) as UIAlertController
                                self.present(myAlert, animated: true, completion: nil)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
            } catch let err {
                print("catch" , err)
            }
        }
        
    }
    
    @objc func textFieldChange(_ textField: UITextField){
        print(textField.tag , textField.text as Any)
        if (textField.tag == 0){
            campaignSms.name = textField.text
        } else {
            campaignSms.link = textField.text
        }
    }
    
    fileprivate func handleSmsManager(){
        let smsManagerController = SmsManagerController()
        let navigateController = UINavigationController(rootViewController: smsManagerController)
        self.present(navigateController, animated: true, completion: nil)
    }
}

