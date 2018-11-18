//
//  FormCampaignController.swift
//  advanSales
//
//  Created by alex on 26/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FormCampaignController : UIViewController {
    
    private let global = Global()
    var formCampaniaViewBottomAnchor : NSLayoutConstraint?
    lazy var formCampaignView : FormCampaignView = {
        let view = FormCampaignView()
        view.formCampaignController = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationController?.navigationBar.tintColor = .black
        setupLayout()
        getHeadersArchivo()
        setupKeyboardObservers()
    }
    
    fileprivate func setupLayout(){
        view.addSubview(formCampaignView)
        
        formCampaignView.topAnchor.constraint(equalTo: view.topAnchor , constant : 100 ).isActive = true
        formCampaignView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant : 10).isActive = true
        formCampaignView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant : -10).isActive = true
        formCampaniaViewBottomAnchor = formCampaignView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        formCampaniaViewBottomAnchor?.isActive = true
    }
    
    fileprivate func getHeadersArchivo(){
        let sv = UIViewController.displaySpinner(onView: self.view , text : "CARGANDO")
        print("getHeadersArchivo")
        DispatchQueue.main.async{
            let url : String = self.global.URL + "archive"
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
                                let data = try JSONEncoder().encode(json["archivos"])
                                self.formCampaignView.archive = try JSONDecoder().decode( Archive.self, from: data)
                                self.view.reloadInputViews()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func setupKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(hadleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hadleKeyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hadleKeyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboarDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        print(keyboardViewEndFrame.height)
        formCampaniaViewBottomAnchor?.constant = -keyboardViewEndFrame.height
        
        UIView.animate(withDuration: keyboarDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hadleSave(){
        print("save" , formCampaignView.call as Any)
        let campaniaController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigareController = UINavigationController(rootViewController: campaniaController)
        self.present(navigareController, animated: true, completion: nil)
    }
}
