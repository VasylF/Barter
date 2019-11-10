//
//  LoginViewController.swift
//  Barter
//
//  Created by Vasyl on 9/21/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//
import UIKit
import SwiftUI
import Firebase

final class LoginViewController: UIViewController {
    
    // MARK: UITextFields
    @IBOutlet private weak var emailTextField: FloatLabelTextField!
    @IBOutlet private weak var passwordTextField: FloatLabelTextField!
    
    // MARK: Buttons
    @IBOutlet private weak var logInButton: UIButton!
    
    // MARK: UITextFields' label
    @IBOutlet private weak var emailHintMessage: UILabel!
    @IBOutlet private weak var passwordHintMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap()
    }

    @IBAction private func logInButtonPressed(_ sender: Any) {
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
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            var message = ""
            if error == nil {
                message = "Login success"
            } else {
                message = error?.localizedDescription ?? "Login error"
            }
            let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    private func hideHintLabels() {
        emailHintMessage.hide()
        passwordHintMessage.hide()
    }
}
