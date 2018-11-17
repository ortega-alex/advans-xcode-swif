//
//  User.swift
//  Advans
//
//  Created by alex on 8/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import Foundation

struct User {
    
    static let (idKey , id_accesoKey , nameKey , usernameKey , languageKey ) = ("id" , "id_acceso" , "name" , "username" , "language")
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var id : String?
        var id_acceso: String?
        var name: String?
        var username : String?
        var language : String?
        
        init(_ json: [String: String]) {
            self.id = json[idKey]
            self.id_acceso = json[id_accesoKey]
            self.name = json[nameKey]
            self.username = json[usernameKey]
            self.language = json[languageKey]
        }
    }
    
    static var save = { (id : String , id_acceso: String, name: String , username : String ,  language : String) in
        UserDefaults.standard.set([idKey : id , id_accesoKey: id_acceso, nameKey: name , usernameKey : username , languageKey : language], forKey: userSessionKey)
    }
    
    static var get = { _ -> Model in
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }(())
    
    static func clear(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
