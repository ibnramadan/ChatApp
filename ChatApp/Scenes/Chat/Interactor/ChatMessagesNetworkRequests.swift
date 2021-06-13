//
//  ChatNetworkRequests.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//

import Foundation
import ObjectMapper
import Alamofire


class ChatMessagesNetworkRequestsImplementation: PaginationNetworkRequests {
    func loadElements<T>(type: T.Type, specificURL: String?, params: Parameters?, queryString: String?, customHeaders: [String : String]?, completionHandler: @escaping (AFResult<ResponseArrayPaginatable<T>?>) -> Void) where T : BaseMappable {
        
   
        let request = ChatMessagesRouter.getMessages(specificURL: specificURL, params: params, queryString: queryString,customHeaders: customHeaders)
        AF.request(request).responseJSON { response in
                   switch response.result {
                   case let .success(value):
                    let response = Mapper<ResponseArrayPaginatable<T>>().map(JSON: value as! [String:Any])
                    completionHandler(.success(response))
                   case let .failure(error):
                       completionHandler(.failure(error))
                   }
               }
    }
    

}
 

