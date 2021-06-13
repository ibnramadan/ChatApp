//
//  GetMyFriendModel.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//

import Foundation
import ObjectMapper

struct GetMyFriendModel : Mappable {
    var deleted : Bool?
    var user : friend?
    var createdAt : String?
    var updatedAt : String?
    var id : Int?
    var friend : friend?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        deleted <- map["deleted"]
        user <- map["user"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        id <- map["id"]
        friend <- map["friend"]
    }

}



