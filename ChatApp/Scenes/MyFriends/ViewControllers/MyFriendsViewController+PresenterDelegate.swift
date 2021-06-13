//
//  MyFriendsViewController+PresenterDelegate.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//


import Foundation
extension MyFriendsViewController : MyFriendsView {
  
  
 
    func showIndicator(){
        self.showLoader()
    }
    func hideIndicator(){
        self.dismissLoader()
    }
    func fetchingDataSuccess(){
        tableView.reloadData()
    }
    func fetchNewRows(newAvailableIndexes: [Int]){
     //   tableView.reloadData()
        self.tableView.insertRows(at: newAvailableIndexes.map({ IndexPath(row: $0, section: 0) }), with: .fade)
    }
    func showError(error: String){
        self.showHint(message: error)
    }
    func addedFriendSuccesfully() {
        self.showHint(message: "Friend Added Succesfully")
    }

    
    func selectFriendSuccesfully(friend: friend) {
        let chatVC = Storyboard.Chat.instantiate(ChatViewController.self)
        chatVC.friend = friend
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
}


