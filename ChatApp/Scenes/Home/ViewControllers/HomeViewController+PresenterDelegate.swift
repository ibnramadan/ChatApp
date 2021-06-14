//
//  HomeViewController+PresenterDelegate.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//


import Foundation
extension HomeViewController : HomeView {
  
 
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
       // tableView.reloadData()
        self.tableView.insertRows(at: newAvailableIndexes.map({ IndexPath(row: $0, section: 0) }), with: .fade)
    }
    func showError(error: String){
        self.showHint(message: error)
    }
    func addedFriendSuccesfully() {
        self.showHint(message: "Friend Added Succesfully")
    }
    
}

