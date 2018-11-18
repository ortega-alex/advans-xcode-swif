//
//  SmsManagerController.swift
//  Advans
//
//  Created by alex on 7/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SmsManagerController: UITableViewController {
   
    private let cellId = "cellId"
    var campaings = [CampaignSmsDecodable]()
    private let global = Global()
    
    override func viewDidLoad() {
       super.viewDidLoad()
       tableView.register(SmsManagerView.self, forCellReuseIdentifier: cellId)
        getCampaign()
        
        let addImage = UIImage(named : "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(handleHome))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.title = "SMS MANAGER"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //line que divide el nav con el view
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationController?.navigationBar.tintColor = .black
        
        //elimina las lineas de separacion
        tableView.separatorStyle = .none
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return campaings.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( campaings[section].opened == true ) {
            return 2
        }else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ( indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SmsManagerView
            cell.backgroundColor = UIColor.lightGray
            cell.ampliarButton.tag = indexPath.section
            cell.smsManagerController = self
            cell.campaing = self.campaings[indexPath.row]
            return cell
        } else {
            let smsManagerDetailView = SmsManagerDetailView()
            smsManagerDetailView.campaing = self.campaings[indexPath.row]
            smsManagerDetailView.smsManagerController = self
            smsManagerDetailView.linkButon.tag = indexPath.section
            smsManagerDetailView.playButton.tag = indexPath.section
            smsManagerDetailView.deleteButton.tag = indexPath.section
            return smsManagerDetailView
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @objc func handleExpandClose(_ button: UIButton){
        print(button.tag)
        if ( campaings[button.tag].opened == true ) {
            campaings[button.tag].opened = false
        } else {
            campaings[button.tag].opened = true
        }
        let sections = IndexSet.init(integer: button.tag)
        tableView.reloadSections(sections, with: .none)
    }
    
    fileprivate func getCampaign(){
        let sv = UIViewController.displaySpinner(onView: self.view , text : "CARGANDO")
        print("getCampania")
        guard let id = User.get.id else {
            UIViewController.removeSpinner(spinner: sv)
            return
        }
        DispatchQueue.main.async{
            let url : String = self.global.URL + "sms/" + id
            Alamofire.request(
                url ,
                method: .get  ,
                headers: self.global.HEADERS
                ).responseJSON(completionHandler: { (response) in
                    UIViewController.removeSpinner(spinner: sv)
                    switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        if ( json["status"].stringValue == "ok" ) {
                            do {
                                let data = try JSONEncoder().encode(json["smss"])
                                self.campaings = try JSONDecoder().decode([CampaignSmsDecodable].self, from: data)
                                self.tableView.reloadData()
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
    
    @objc func handleLink(_ button: UIButton){
        print("link" , button.tag)
    }
    
    @objc func handlePlay(_ button: UIButton){
        print("paly" , button.tag)
    }
    
    @objc func handleDelete(_ button: UIButton){
        print("delete" , button.tag)
    }
    
    @objc private func handleHome(){
        let campaignController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigateController = UINavigationController(rootViewController: campaignController)
        self.present(navigateController, animated: true, completion: nil)
    }
}
