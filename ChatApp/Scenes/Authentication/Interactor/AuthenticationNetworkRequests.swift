//
//  AuthenticationNetworkRequests.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation
import ObjectMapper
import Alamofire

protocol AuthenticationNetworkRequests {
    func login(phone: String, password: String, completionHandler: @escaping (AFResult<LoginData?>) -> Void)
}

class AuthenticationNetworkRequestsImplementation: AuthenticationNetworkRequests {
   
    
    func login(phone: String, password: String, completionHandler: @escaping (AFResult<LoginData?>) -> Void) {
        let request = AuthenticationRouter.login(phone: phone, password: password)
        AF.request(request).responseJSON { response in
            switch response.result {
            case let .success(value):
                let response = Mapper<LoginData>().map(JSON: value as! [String:Any])
                completionHandler(.success(response))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
        
    }


    
}

