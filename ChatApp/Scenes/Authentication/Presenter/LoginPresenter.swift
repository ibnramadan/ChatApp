//
//  LoginPresenter.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation
import UIKit
protocol LoginView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func loginSuccessfully()
    func showError(error: String)
}




class LoginPresenter {
      private weak var view: LoginView?
     private let networkInstance: AuthenticationNetworkRequests = AuthenticationNetworkRequestsImplementation()

      init(view: LoginView) {
          self.view = view
      }

     func login(_ phone: String, password: String) {
        view?.showIndicator()
        networkInstance.login(
            phone: phone,
            password: password) { [weak self] (response) in
                guard let self = self else { return }
            self.view?.hideIndicator()
                switch response {
                case let .success(result) where result?.token != nil:
                    result?.saveToUserDefaults()
                    self.view?.loginSuccessfully()
                case let .success(result):
                    self.view?.showError(error:result?.message ??  "Server Error")
                case let .failure(error) :
                    print(error.localizedDescription)
                    self.view?.showError(error: "Server Error")
                }
        }
    }
    
}

