//
//  HomeRouter.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//

import Foundation
import Alamofire

enum HomeRouter: URLRequestConvertible {
    
    case getUsers(specificURL: String?, params: Parameters?, queryString: String?, customHeaders: [String : String]?)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch  self {
            case .getUsers:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case  .getUsers:
                return nil
            }
        }()
        
        let custonHeaders: ([String: String]?) = {
            switch self {
            case  .getUsers:
                          return nil
            }
        }()

        let headers = NetworkConstants.generalAppHeaders.merging(custonHeaders ?? [:]) { (_, k2) -> String in
            return k2
        }
        
        let url: URL = {
            switch self {
            case let .getUsers( specificURL, _, queryString, _):
                   return URL(string: (specificURL ?? NetworkConstants.EndPoints.getAll) + (queryString ?? "") )!
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.allHTTPHeaderFields = headers
        
        let encoding: ParameterEncoding = {
            return JSONEncoding.default
        }()
        
        return try! encoding.encode(urlRequest, with: params)
    }
    
    
}
