//
//  UIViewController.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation
import UIKit
import KRProgressHUD
import Toast_Swift



extension UIViewController {
 
    public static var storyboardIdentifier: String {
           return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    func showLoader(){
      KRProgressHUD.show(withMessage: "Loading...", completion: nil)
        
    }
    
    func dismissLoader(){
        KRProgressHUD.dismiss()
        
    }


    
    func showHint(message: String) {
        self.view.makeToast(message, duration: 3.0, position: .bottom)
    }
}

