//
//  UIView+Circle.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import Foundation
import UIKit

extension UIView {
    
    
@IBInspectable var isCircled: Bool {
    get {
        return false
    }
    set {
        if newValue {
            self.cornerRadius = self.bounds.height / 2
        }
    }
}

}




extension UIImageView {
    func circleImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}

