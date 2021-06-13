//
//  ChatViewController+PresenterDelegate.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//


import Foundation
extension ChatViewController : ChatView {
   

    func showIndicator(){
        self.showLoader()
    }
    func hideIndicator(){
        self.dismissLoader()
    }
    func fetchingDataSuccess(){
        chatMessagesTableView.reloadData()
        presenter.sendSeeMessage(friendId: friend?.id ?? 0)
    }
    func fetchNewRows(newAvailableIndexes: [Int]){
     //   tableView.reloadData()
        self.chatMessagesTableView.insertRows(at: newAvailableIndexes.map({ IndexPath(row: $0, section: 0) }), with: .fade)
        chatMessagesTableView.scrollToRow(at: IndexPath(item: chatMessagesTableView.numberOfRows(inSection: 0) - 1, section: 0), at: .bottom, animated: false)
    }
    func showError(error: String){
        self.showHint(message: error)
    }
  
    func messageSentSuccessfully() {
        self.msgText.text = ""
        chatMessagesTableView.reloadData()
    }
    
}


