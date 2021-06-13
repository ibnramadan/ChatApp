//
//  LoginViewController+PresenterDelegate.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation

extension LoginViewController : LoginView {

    func showIndicator() {
         self.showLoader()
    }
    
    func hideIndicator() {
        self.dismissLoader()
    }
    
    func loginSuccessfully() {
        let home = Storyboard.Main.instantiateInitialViewController()
        self.navigationController?.setViewControllers([home], animated: true)
    }
    
    func showError(error: String) {
        self.showHint(message: error)
    }
    
    
    
    
}

