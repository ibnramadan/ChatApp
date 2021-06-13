//
//  chatMessage.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//


import Foundation
import ObjectMapper

struct chatMessage : Mappable {
    var seen: Bool?
    var _id: Int?
    var content : String?
    var createdAt: String?
    var user: friend?

    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        seen <- map["seen"]
        _id <- map["_id"]
        content <- map["content"]
        createdAt <- map["createdAt"]
        user <- map["user"]
    }

}



