//
//  Response.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation
import ObjectMapper

struct Response<T: BaseMappable>: Mappable {
    var data : T?
    var message: String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        data <- map["data"]
        message <- map["message"]
    }

}
