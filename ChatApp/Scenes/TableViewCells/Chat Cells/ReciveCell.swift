//
//  ReciveCell.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//

import UIKit

class ReciveCell: UITableViewCell , ChatRecieverCellView {

   
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var msgL: UILabel!
    @IBOutlet weak var dateL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func displayMessageText(name: String) {
        msgL.text = name
     }
    func displaydateLabel(name: String) {
        dateL.text = name
     }
    

}
