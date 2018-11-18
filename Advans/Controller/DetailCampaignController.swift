//
//  DetailCampanignController.swift
//  Advans
//
//  Created by alex on 31/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailCampaignController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    private let global = Global()
    private let cellId = "cellId"
    private let headerId = "headerId"
    var campaign : Campaign?
    var id : String = "0"
    var calls = [Call]()
    
    private let continueButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .black, text: "Continue")
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DetailCampaignView.self , forCellWithReuseIdentifier: cellId)
        collectionView.register(CampaignView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        collectionView?.isPagingEnabled = true
        
        let addImage = UIImage(named : "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(hadkeBack))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        //fuerza el color det titulo
        navigationItem.title = campaign?.name
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //line que divide el nav con el view
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationController?.navigationBar.tintColor = .black
        collectionView.backgroundColor = .white
        
        getCalls()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailCampaignView
        cell.detailCampaignController = self
        cell.backgroundColor = .white
        cell.editButton.tag = indexPath.item
        cell.noteButton.tag = indexPath.item
        cell.callButton.tag = indexPath.item
        let call = calls[indexPath.item]
        cell.call = call
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CampaignView
        header.detailCampaignController = self
        header.backgroundColor = .white
        header.campaign = self.campaign
        header.trashButton.isHidden = true
        header.addButton.isHidden = true
        if (campaign?.type == "M") {
            header.greenButton.isHidden = true
        }
        header.addSubview(continueButton)
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: header.bottomAnchor , constant : -5),
            continueButton.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            continueButton.widthAnchor.constraint(equalTo: header.widthAnchor, constant: -10),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 190)
    }
    
    @objc func hadleTouchUpInside(_ button : UIButton){
        if button.layer.borderColor == UIColor.white.cgColor {
            button.layer.borderColor = UIColor.gray.cgColor
        } else {
            button.layer.borderColor = UIColor.white.cgColor
        }
        print("TouchUpInside id_stado: " , button.tag , "id_campania: " , button.titleLabel?.text as Any )
        collectionView.reloadData()
    }
    
    @objc func hadleEdit(_ button: UIButton){
        print("edit")
        print(calls[button.tag])
        let tracingController = TracingController(collectionViewLayout: UICollectionViewFlowLayout())
        tracingController.call = calls[button.tag]
        navigationController?.pushViewController(tracingController, animated: true)
    }
    
    @objc func hadleNote(_ button: UIButton){
        print("note")
        print(calls[button.tag].notes as Any)
    }
    
    @objc func hadleCall(_ button: UIButton){
        print("call")
        print(calls[button.tag].phone as Any)
    }
    
    @objc func hadkeBack(){
        let campaignController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigareController = UINavigationController(rootViewController: campaignController)
        self.present(navigareController, animated: true, completion: nil)
    }
    
    private func getCalls(){
        let sv = UIViewController.displaySpinner(onView: self.view , text : "CARGANDO")
        DispatchQueue.main.async{
            let url : String = self.global.URL + "call/\(self.id)/" + self.campaign!._id!
            Alamofire.request(
                url ,
                method: .get  ,
                headers: self.global.HEADERS
                ).responseJSON(completionHandler: { (response) in
                    UIViewController.removeSpinner(spinner: sv)
                    switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        if ( json["status"].stringValue == "success" ) {
                            do {
                                let data = try JSONEncoder().encode(json["calls"])
                                self.calls = try JSONDecoder().decode([Call].self, from: data)
                                //self.refresh.endRefreshing()
                                self.collectionView.reloadData()
                            } catch let err {
                                print("err: " , err)
                            }
                        } else {
                            let myAlert = self.global.alert(title: "msj", message: json["msj"].stringValue ) as UIAlertController
                            self.present(myAlert, animated: true, completion: nil)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
        }
    }
}
