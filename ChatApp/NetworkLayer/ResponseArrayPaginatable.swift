//
//  ResponseArrayPaginatable.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation

import ObjectMapper

struct ResponseArrayPaginatable<T: BaseMappable> : Mappable {

    var page : Int?
    var pageCount : Int?
    var limit : Int?
    var totalCount : Int?
    var links : links?
    var message : String?
    var data : [T]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        page <- map["page"]
        pageCount <- map["pageCount"]
        limit <- map["limit"]
        totalCount <- map["totalCount"]
        links <- map["links"]
        message <- map["message"]
        data <- map["data"]
    }

}

