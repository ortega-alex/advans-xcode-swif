//
//  LoginController.swift
//  Advans
//
//  Created by alex on 8/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginController : UIViewController {
    
    let global = Global()
    lazy var loginView : LoginView = {
        let login = LoginView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        login.loginController = self
        return login
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(loginView)
        let deladline = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deladline, execute: getUser)
    }
    
    private func getUser(){
        print(User.get)
    }
    
    @objc func hadleLogin(){        
        guard let username = loginView.addressTextField.text , let password = loginView.passwordTextField.text  else {
            let myAlert = global.alert(title: "obligatorios", message: "ingrese el correo y contrasenia") as UIAlertController
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        DispatchQueue.main.async{
            let url : String = self.global.URL + "login"
            let para : Parameters = [
                "username" : username ,
                "password" : password
            ]
            Alamofire.request(
                url ,
                method: .post  ,
                parameters: para ,
                encoding: JSONEncoding.default ,
                headers: self.global.HEADERS
                ).responseJSON(completionHandler: { (response) in
                    switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        if ( json["status"].stringValue == "success" ) {
                            User.save(
                                json["user"]["_id"].stringValue ,
                                json["user"]["access"]["_id"].stringValue ,
                                json["user"]["name"].stringValue ,
                                json["user"]["access"]["username"].stringValue ,
                                json["user"]["language"].stringValue
                            )
                            let campaingController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
                            let navigareController = UINavigationController(rootViewController: campaingController)
                            self.present(navigareController, animated: true, completion: nil)
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
    
    @objc func hadleRegister(){
        let layout = UICollectionViewFlowLayout()
        let registerController = RegisterController(collectionViewLayout : layout)
        layout.scrollDirection = .horizontal
        present(registerController, animated: true, completion: nil)
    }
    
}
