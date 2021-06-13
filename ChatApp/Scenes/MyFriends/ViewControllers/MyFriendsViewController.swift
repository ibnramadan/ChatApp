//
//  MyFriendsViewController.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//

import UIKit

class MyFriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: MyFriendsPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        presenter = MyFriendsPresenter(view: self)
        presenter.getMyFriends()
    }

}
