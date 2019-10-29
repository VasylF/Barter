//
//  SignInViewController.swift
//  Barter
//
//  Created by Vasyl on 9/29/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit
import Firebase
import ACFloatingTextfield_Swift

private typealias Const = Constants.Text.SignInViewController

private enum TextFieldType {
    case firstName
    case lastName
    case email
    case password
}

class SignInViewController: UIViewController {
    // MARK: UITextFields
    @IBOutlet private weak var firstNameTextField: ACFloatingTextfield!
    @IBOutlet private weak var lastNameTextField: ACFloatingTextfield!
    @IBOutlet private weak var emailTextField: ACFloatingTextfield!
    @IBOutlet private weak var passwordTextField: ACFloatingTextfield!
    
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: UITextFields' label
    @IBOutlet private weak var firstNameHintLabel: UILabel!
    @IBOutlet private weak var lastNameHintLabel: UILabel!
    @IBOutlet private weak var emailHintLabel: UILabel!
    @IBOutlet private weak var passwordHintLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        hideAndClearHintLabel()
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        var shouldFailSignIn = false
        
        // First Name
        if firstName.isEmpty {
            shouldShow(label: firstNameHintLabel)
            shouldFailSignIn = true
        }
        
        // Last Name
        if lastName.isEmpty {
            shouldShow(label: lastNameHintLabel)
            shouldFailSignIn = true
        }
        
        // Email
        if email.isEmpty || !email.isValidEmail {
            emailHintLabel.text = email.isEmpty
                ? Const.hintEmailAbsent
                : Const.hintEmailIncorrect
            shouldShow(label: emailHintLabel)
            shouldFailSignIn = true
        }
                
        // Password
        let passwordValidation = ExtenededPasswordValidator(password)
        
        if password.isEmpty || !passwordValidation.errors.isEmpty {
            var errors: [String] = []
            passwordValidation.errors.forEach { errors.append("*\($0.description)") }
            passwordHintLabel.text = password.isEmpty
                ? Const.hintPassword
                : errors.joined(separator: "\n")
            shouldShow(label: passwordHintLabel)
            shouldFailSignIn = true
        }

        guard shouldFailSignIn else { return }
        
        Auth.auth().createUser(withEmail: "", password: "") { (user, error) in
            
        }
    }
}

private extension SignInViewController {
    func shouldShow(_ show: Bool = true, label: UILabel) {
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
            label.isHidden = !show
            self.stackView.layoutIfNeeded()
            self.stackView.setNeedsLayout()
            self.stackView.setNeedsDisplay()
        }
    }
    
    func configureTextFields() {
        firstNameTextField.configureTextField()
        lastNameTextField.configureTextField()
        emailTextField.configureTextField()
        passwordTextField.configureTextField()
    }
    
    func hideAndClearHintLabel() {
        emailHintLabel.text = ""
        passwordHintLabel.text = ""
        shouldShow(false, label: firstNameHintLabel)
        shouldShow(false, label: lastNameHintLabel)
        shouldShow(false, label: emailHintLabel)
        shouldShow(false, label: passwordHintLabel)
    }
}

extension ACFloatingTextfield {
    func configureTextField() {
//        borderStyle = .line
//        selectedLineColor = .orange
//        textColor = .brown
    }
}
