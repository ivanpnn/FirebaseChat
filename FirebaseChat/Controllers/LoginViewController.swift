//
//  LoginViewController.swift
//  FirebaseChat
//
//  Created by MacBook Noob on 01/02/21.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Log In"
        view.backgroundColor = .blue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Registration"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
