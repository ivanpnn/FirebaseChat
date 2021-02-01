//
//  RegisterViewController.swift
//  FirebaseChat
//
//  Created by MacBook Noob on 01/02/21.
//

import UIKit

class RegisterViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "messenger")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        
        // Add subview
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.frame.size.width / 3
        imageView.frame = CGRect(x: (view.frame.size.width - size) / 2, y: 20, width: size, height: size)
    }

}
