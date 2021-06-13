//
//  Profile.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//
import Foundation
import ObjectMapper

struct Profile : Mappable {
    var friends : [Int]?
    var deleted : Bool?
    var fullname : String?
    var phone : String?
    var createdAt : String?
    var updatedAt : String?
    var id : Int?

    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        friends <- map["friends"]
        deleted <- map["deleted"]
        fullname <- map["fullname"]
        phone <- map["phone"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        id <- map["id"]
    }

}

