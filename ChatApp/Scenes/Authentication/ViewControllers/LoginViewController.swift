//
//  LoginViewController.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//


import UIKit
class LoginViewController: UIViewController  {

    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
        presenter = LoginPresenter(view: self)
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        guard
            let phone = phoneTF.text,
            !phone.trimmingCharacters(in: .whitespaces).isEmpty else {
                self.showHint(message: "Please, enter your phone number.")
                return
            }
        guard
            let password = passwordTF.text,
            !password.trimmingCharacters(in: .whitespaces).isEmpty else {
                self.showHint(message: "Please, enter your password.")
                return
            }
        presenter.login(phone, password:  password)
    
    }
    
 
    @IBAction func registerBtnPressed(_ sender: Any) {
    }
    
}


