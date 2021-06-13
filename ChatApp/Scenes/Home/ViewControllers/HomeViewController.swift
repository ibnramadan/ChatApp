//
//  HomeViewController.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: HomePresenter!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        presenter = HomePresenter(view: self)
        presenter.viewDidLoad()
    }
    


}
