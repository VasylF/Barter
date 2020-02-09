//
//  LoginViewController.swift
//  Barter
//
//  Created by Vasyl on 9/21/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//
import UIKit
import Firebase

class LoginViewController: UIViewController, Storyboarded {
    
    // MARK: UITextFields
    @IBOutlet private weak var emailTextField: FloatLabelTextField!
    @IBOutlet private weak var passwordTextField: FloatLabelTextField!
    
    // MARK: Buttons
    @IBOutlet private weak var logInButton: UIButton!
    
    // MARK: UITextFields' label
    @IBOutlet private weak var emailHintMessage: UILabel!
    @IBOutlet private weak var passwordHintMessage: UILabel!
    
    weak var coordinator: AuthenticationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap()
    }

    @IBAction private func logInButtonPressed(_ sender: Any) {
        showActivityIndicator()
        hideHintLabels()
        var shouldLogIn = true
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // email
        if email.isEmpty {
            emailHintMessage.show()
            shouldLogIn = false
        }
        
        // password
        if password.isEmpty {
            passwordHintMessage.show()
            shouldLogIn = false
        }
        
        guard shouldLogIn else { return }
        
        login(with: email, and: password)
    }
    
    @IBAction private func resetPasswordButtonPressed(_ sender: Any) {
        coordinator?.resetPassword()
    }
    
    @IBAction private func createAccountButtonPressed(_ sender: Any) {
        coordinator?.createAccount()
    }
}


private extension LoginViewController {
    func login(with email: String, and password: String) {
        FirebaseManager.login(with: email, password: password) { [weak self] error in
            guard let self = self else { return }
            
            self.hideActivityIndicator()
            
            if error == nil {
                self.navigateToHomeScreen()
            } else {
                let message = error?.localizedDescription ?? "Login error"
                let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func hideHintLabels() {
        emailHintMessage.hide()
        passwordHintMessage.hide()
    }
    
    func navigateToHomeScreen() {
        coordinator?.navigateToHomeScreen()
    }
}
