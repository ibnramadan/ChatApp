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
    private var task: URLSessionDataTask?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        userImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayUserName(name: String) {
        userNameL.text = name
     }

         func displayUserImage(Url: String) {
           // userImageView.downloadFrom(url: URL)
            guard let url = URL(string: Url) else { return }

             task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                 if let data = data, let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         self.userImageView.image = image
                     }
                 }
             }
             task?.resume()
           
         }
    
    func setBtnTitle(title: String) {
        addFriendBtn.setTitle(title, for: .normal)
    }
}
