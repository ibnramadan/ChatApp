//
//  PaginationNetworkRequests.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//


import Foundation
import ObjectMapper
import Alamofire

protocol PaginationNetworkRequests {
    func loadElements<T:BaseMappable>(type: T.Type, specificURL: String?, params: Parameters?, queryString: String?, customHeaders: [String:String]?, completionHandler: @escaping (AFResult<ResponseArrayPaginatable<T>?>) -> Void)
    
}

