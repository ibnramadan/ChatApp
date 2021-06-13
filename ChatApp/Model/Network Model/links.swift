//
//  links.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//


import Foundation
import ObjectMapper

struct links : Mappable {

    var _self : String?
    var next : String?
    var last : String?

    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        _self <- map["_self"]
        next <- map["next"]
        last <- map["last"]

    }

}



