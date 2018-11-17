//
//  CampaignSms.swift
//  Advans
//
//  Created by alex on 7/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

struct CampaignSms : Codable {
    var name : String?
    var sms_text : String?
    var link : String?
    var start_time : String?
    var start_date : String?
    var calls : [String]?
}

struct CampaignSmsDecodable : Decodable {
    var _id : String?
    var name : String?
    var sms_text : String?
    var link : String?
    var start_time : String?
    var start_date : String?
    var calls : [Call]?
    var creation_date : String?
    var status : String?
    var opened : Bool?
}
