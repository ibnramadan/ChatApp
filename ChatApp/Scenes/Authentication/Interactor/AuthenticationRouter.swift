//
//  AuthenticationRouter.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//


import Foundation
import Alamofire

enum AuthenticationRouter: URLRequestConvertible {
    
    case login(phone: String, password: String)

    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch  self {
            case .login:
                return .post
         
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case let .login(phone, password):
                return [
                    "phone" : phone,
                    "password" : password
                ]
     
            }
        }()
        
        let custonHeaders: ([String: String]?) = {
            switch self {
            case .login:
                return nil
        
            }
        }()

        let headers = NetworkConstants.generalAppHeaders.merging(custonHeaders ?? [:]) { (_, k2) -> String in
            return k2
        }
        
        let url: URL = {
            switch self {
            case .login:
                return URL(string: NetworkConstants.EndPoints.login)!
               
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

