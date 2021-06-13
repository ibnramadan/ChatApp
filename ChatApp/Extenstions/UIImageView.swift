//
//  UIImageView.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//


import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func downloadFrom(url: String, placeHolder: UIImage? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: ((Result<RetrieveImageResult,KingfisherError>)->Void)? = nil) {
        
        guard let _url = URL(string: url) else { return }
        self.kf.setImage(with: _url,
                         placeholder: placeHolder,
                         options: [KingfisherOptionsInfoItem.transition(.fade(0))],
                         progressBlock: progressBlock,
                         completionHandler: completionHandler)
    }
}
