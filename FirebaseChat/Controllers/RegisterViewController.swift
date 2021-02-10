//
//  RegisterViewController.swift
//  FirebaseChat
//
//  Created by MacBook Noob on 01/02/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let firstNameField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "First Name"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let lastNameField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Last Name"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Email Address"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Log In"
        view.backgroundColor = .white
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Add subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
        
        // Enable user interaction
        scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        
        // Add gesture recognizer to UIImageView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePic))
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapProfilePic() {
        profilePictureOption()
    }
    
    @objc private func didTapRegisterButton() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6 else {
            alertUser()
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let result = authResult, error == nil else {
                print(error!)
                return
            }
            
            let user = result.user
            print(user)
        }
      
    }
    
    private func alertUser() {
        let alert = UIAlertController(title: "Whoops!", message: "Please enter all information to continue", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
        imageView.layer.cornerRadius = imageView.width / 2
        
        firstNameField.frame = CGRect(x: 30, y:imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        
        lastNameField.frame = CGRect(x: 30, y:firstNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        emailTextField.frame = CGRect(x: 30, y:lastNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        passwordTextField.frame = CGRect(x: 30, y:emailTextField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        registerButton.frame = CGRect(x: 30, y:passwordTextField.bottom + 10, width: scrollView.width - 60, height: 52)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapRegisterButton()
        }
        
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func profilePictureOption() {
        let optionAlert = UIAlertController(title: "Please select the option", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (UIAlertAction) in
            self?.profilePictureFromCamera()
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] (UIAlertAction) in
            self?.profilePictureFromPhotoLibrary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionAlert.addAction(cameraAction)
        optionAlert.addAction(photoLibraryAction)
        optionAlert.addAction(cancelAction)
        
        present(optionAlert, animated: true, completion: nil)
    }
    
    func profilePictureFromCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func profilePictureFromPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        imageView.image = selectedImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
