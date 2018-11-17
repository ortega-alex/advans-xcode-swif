//
//  Campaign.swift
//  Advans
//
//  Created by alex on 18/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

struct Campaign : Decodable {
    var _id : String?
    var name : String?
    var type : String?
    var creation_date : String?
    var call_states : [Call_state]?
}

struct Call_state : Decodable {
    var _id : String?
    var id  : Int
    var name:  String?
    var calls : Int
    var selectd : Bool?
}

struct Call : Decodable {
    var _id : String?
    var notes : [String]?
    var sms : Bool?
    var sms_text : String?
    var reminder : String?
    var name : String?
    var phone : String?
    var field1 : String?
    var field2 : String?
    var field3 : String?
    var field4 : String?
}
