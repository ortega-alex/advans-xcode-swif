//
//  Archive.swift
//  Advans
//
//  Created by alex on 26/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

struct Archive : Decodable {
    var name : String
    var headers : [Header]
}

struct Header : Decodable {
    var text : String
    var position : String
}

