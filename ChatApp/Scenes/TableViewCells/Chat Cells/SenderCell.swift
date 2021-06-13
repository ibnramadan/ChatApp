//
//  SenderCell.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//

import UIKit

class SenderCell: UITableViewCell  , ChatSenderCellView{
    @IBOutlet weak var msgView: UIView!
 
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var msgStatusImage: UIImageView!
    @IBOutlet weak var msgL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func displayMessageText(name: String) {
        msgL.text = name
     }
    func displaydateLabel(name: String) {
        dateL.text = name
     }
   
    func displayMsgStatusImage(status : Bool = false){
        if status {
            msgStatusImage.image = UIImage(named: "double-tick-indicator")
        }else {
            msgStatusImage.image = UIImage(named: "check-mark")
        }
    }
   
}
