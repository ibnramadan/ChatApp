//
//  friend.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation
import ObjectMapper

struct friend : Mappable {
    var deleted : Bool?
    var fullname : String?
    var phone : String?
    var img : String?
    var createdAt : String?
    var updatedAt : String?
    var id : Int?
    var friends : [Int]?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        deleted <- map["deleted"]
        fullname <- map["fullname"]
        phone <- map["phone"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        id <- map["id"]
        img <- map["img"]
        friends <- map["friends"]
    }

}


