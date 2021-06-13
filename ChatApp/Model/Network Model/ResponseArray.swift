//
//  ResponseArray.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation
import ObjectMapper

struct ResponseArray<T: BaseMappable>: Mappable {
    var status : Bool?
    var locale : String?
    var data : [T]?
    var message: String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["success"]
        locale <- map["locale"]
        data <- map["data"]
        message <- map["message"]
    }

}


