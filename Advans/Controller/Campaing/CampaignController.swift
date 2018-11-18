//
//  CampaignController.swift
//  advanSales
//
//  Created by alex on 8/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CampaignController: UICollectionViewController  {
    
    private let global = Global()
    var campaigns = [Campaign]()
    let cellId = "cellId"
    
    private lazy var refresh : UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.tintColor = .red
        ref.addTarget(self, action: #selector(getCampania), for: .valueChanged)
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
        let myAttrString = NSAttributedString(string: "Pull to refresh", attributes: myAttribute)
        ref.attributedTitle = myAttrString
        return ref
    }()
    
    private let imageTitleView : UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "title")
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var btnFoalt : UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: ((self.collectionView.frame.size.width / 2) - 30) , y: (self.collectionView.frame.size.height - 80) , width: 60, height: 60)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.setTitle("SYNC", for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(hadleSync), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //elimina el color y el borde de separacion del tableView
        //self.tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        
        let addImage = UIImage(named : "add")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(hadleLogout))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.titleView = imageTitleView
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        
        let image = UIImage(named: "menu")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image , style: .plain, target: self, action: #selector(hadleMenu))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        collectionView.register(CampaignViewCell.self , forCellWithReuseIdentifier: cellId)
        
        let deladline = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deladline, execute: getUser)
        
        getCampania()
        collectionView.backgroundColor = .white
        collectionView.refreshControl = refresh
        collectionView.addSubview(btnFoalt)
    }
    
    private func getUser(){
        print(User.get)
    }
    
    @objc private func hadleMenu(){
        //print("menu")
        let layout = UICollectionViewFlowLayout()
        let menuController = MenuController(collectionViewLayout : layout)
        menuController.campaings = self.campaigns
        let navigateController = UINavigationController(rootViewController: menuController)
        self.present(navigateController, animated: true, completion: nil)
    }
    
    @objc private func hadleLogout(){
        //print("logout")
        User.clear()
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    @objc private func getCampania(){
        let sv = UIViewController.displaySpinner(onView: self.view , text : "CARGANDO")
        print("getCampania")
        guard let id = User.get.id else {
            UIViewController.removeSpinner(spinner: sv)
            return
        }
        DispatchQueue.main.async{
            let url : String = self.global.URL + "campaign/" + id
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
                            let data = try JSONEncoder().encode(json["campaigns"])
                            self.campaigns = try JSONDecoder().decode([Campaign].self, from: data)
                            self.refresh.endRefreshing()
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
    
    @objc func hadleDeleteCampania(_ button : UIButton){
        //print("delete campania id_campania: " , campaigns[button.tag]._id as Any )
        DispatchQueue.main.async{
            let url : String = self.global.URL + "campania/" + self.campaigns[button.tag]._id!
            Alamofire.request(
                url ,
                method: .delete  ,
                headers: self.global.HEADERS
            ).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    if ( json["status"].stringValue == "ok" ) {
                        self.getCampania()
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
    
    @objc func hadleAddCampania(_ button : UIButton){
        //print("add campania id_campania: " , self.campaigns[button.tag] as Any)
        let markerController = MarkerController(collectionViewLayout: UICollectionViewFlowLayout())
        var call = Call()
        call.name = self.campaigns[button.tag].name
        markerController.call = call
        navigationController?.pushViewController(markerController, animated: true)
    }
    
    @objc func hadleTouchUpInside(_ button : UIButton){
        //print("TouchUpInside id_campania: " , button.titleLabel?.text as Any  , "stado: " , button.tag )
        let detailCampaignController = DetailCampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        detailCampaignController.campaign = self.campaigns[Int((button.titleLabel?.text)!)!]
        detailCampaignController.id = String(describing: button.tag)
        let navigareController = UINavigationController(rootViewController: detailCampaignController)
        self.present(navigareController, animated: true, completion: nil)
    }
    
    @objc func hadleSync(){
        print("sycn")
    }
}
