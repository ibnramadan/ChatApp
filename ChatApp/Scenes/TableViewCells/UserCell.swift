//
//  UserCell.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//

import UIKit

class UserCell: UITableViewCell , UserCellView{
    
    
 
    

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameL: UILabel!
    @IBOutlet weak var addFriendBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayUserName(name: String) {
        userNameL.text = name
     }

         func displayUserImage(URL: String) {
            userImageView.downloadFrom(url: URL)
         }
    
    func setBtnTitle(title: String) {
        addFriendBtn.setTitle(title, for: .normal)
    }
}
