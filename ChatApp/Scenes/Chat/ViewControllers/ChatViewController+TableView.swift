//
//  ChatViewController+TableView.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//


import Foundation
import UIKit
extension ChatViewController : UITableViewDelegate , UITableViewDataSource {
    
    func setupTableView() {
        chatMessagesTableView.delegate = self
        chatMessagesTableView.dataSource = self
        chatMessagesTableView.isUserInteractionEnabled = true
        chatMessagesTableView.allowsSelection = true
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getMessagesCount()
        
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ChatSenderCell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! SenderCell
        let ChatRecieverCell = chatMessagesTableView.dequeueReusableCell(withIdentifier: "ReciveCell", for: indexPath) as!
            ReciveCell
        presenter.configure(ChatSenderCell: ChatSenderCell, ChatRecieverCell: ChatRecieverCell, for: indexPath.row)
        if  presenter.ChatMessagesProvider.elements[indexPath.row].user?.id == LoginData.loadSavedLoginData()?.user?.id ?? 0 {
            return ChatSenderCell
        }else {
            return ChatRecieverCell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      
    }
    
 
    
}


