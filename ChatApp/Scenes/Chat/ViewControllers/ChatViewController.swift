//
//  ChatViewController.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatMessagesTableView: UITableView!
    @IBOutlet weak var msgText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
  
    
    var presenter: ChatPresenter!
    var friend : friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        presenter = ChatPresenter(view: self)
        getMessgaes()
        setup()
    }
    
    func getMessgaes(){
        presenter.getMessages(myId: LoginData.loadSavedLoginData()?.user?.id ?? 0, friendId: friend?.id ?? 0)
    }
    private func setup() {

        usernameLabel.text = friend?.fullname
        sendButton.isEnabled = false
        sendButton.alpha = 0.5
        if let url = friend?.img  {
            userImageView.downloadFrom(url: url)
        }

    }
    

    @IBAction func backButtonTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    
    @IBAction func sendButtonTapped(_ sender: UIButton) {

        guard let message = self.msgText.text else {
            return
        }
        presenter.sendNewMessage(friendId: friend?.id ?? 0, message: message)
      
    }
    @IBAction func textMessageChanged(_ sender: Any) {
        sendButton.isEnabled = isEnabled()
    }
    
   
}


extension ChatViewController {
    
    private func isEnabled() -> Bool {
        
        if !(msgText.text?.isEmpty)! {
            
            sendButton.alpha = 1.0
            return true
        }
        
        sendButton.alpha = 0.5
        return false
    }
    
    
    
}
