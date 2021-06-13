//
//  NetworkConstants.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation

enum NetworkConstants {
    static var generalAppHeaders : [String : String] {
        return [
            "Accept" : "application/json",
            "Authorization" : LoginData.loadSavedLoginData()?.token
            ].compactMapValues { $0 }
    }
    static var baseUrl = "http://task-ksa.herokuapp.com/api/"

    enum EndPoints {
        static let login = baseUrl + "v1/signin"
        static let register = baseUrl + "v1/signup"
        static let getAll = baseUrl + "v1/getAll"
        static let getMyFriend = baseUrl + "v1/friends"
        static let getMessages = baseUrl + "v1/messages"
    }
}

