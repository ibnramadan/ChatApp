//
//  HomeViewController+TableView.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//

import Foundation
import UIKit
extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getUsersCount()
        
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        presenter.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let alertController = UIAlertController(title: "Add Friend", message: "Are you sure you want to add this friend", preferredStyle: .alert)
        

        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.presenter.didSelectRow(for: indexPath.row)
        }
        
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
 
    
}

