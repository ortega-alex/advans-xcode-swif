//
//  Global.swift
//  Advans
//
//  Created by alex on 16/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class Global: NSObject {
    
    let URL : String = "http://192.168.1.57:3000/"
    let HEADERS = [ "Content-Type" : "application/json"]
    
    func alert(title: String, message: String) -> UIAlertController {
        let myAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return myAlert
    }
}
