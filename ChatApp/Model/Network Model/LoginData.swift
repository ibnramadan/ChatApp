//
//  LoginData.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//


import Foundation
import ObjectMapper

struct LoginData : Mappable {
    var token : String?
    var user : Profile?
    var message: String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        token <- map["token"]
        user <- map["user"]
        message <- map["message"]
    }

}

extension LoginData {
    func saveToUserDefaults() {
        UserDefaults.standard.set(self.toJSON(), forKey: UserDefaultsKeys.savedLoginData)
    }
    
    static func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.savedLoginData)
    }
    
    static func loadSavedLoginData() -> LoginData? {
        guard let loginDataJSON = UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.savedLoginData) else { return nil }
        return LoginData(JSON: loginDataJSON)
    }
}

