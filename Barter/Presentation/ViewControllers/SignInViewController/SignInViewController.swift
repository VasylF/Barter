//
//  SignInViewController.swift
//  Barter
//
//  Created by Vasyl on 9/29/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit
import Firebase

private typealias Const = K.Text.SignInViewController

private enum TextFieldType {
    case firstName
    case lastName
    case email
    case password
}

class SignInViewController: UIViewController, Storyboarded {
    // MARK: UITextFields
    @IBOutlet private weak var firstNameTextField: FloatLabelTextField!
    @IBOutlet private weak var lastNameTextField: FloatLabelTextField!
    @IBOutlet private weak var emailTextField: FloatLabelTextField!
    @IBOutlet private weak var passwordTextField: FloatLabelTextField!
    
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: UITextFields' label
    @IBOutlet private weak var firstNameHintLabel: UILabel!
    @IBOutlet private weak var lastNameHintLabel: UILabel!
    @IBOutlet private weak var emailHintLabel: UILabel!
    @IBOutlet private weak var passwordHintLabel: UILabel!
    
    weak var coordinator: AuthenticationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap()
    }
    
    @IBAction private func signInButtonPressed(_ sender: Any) {
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

        guard !shouldFailSignIn else { return }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            var message: String = ""
            if let user = user {
                let changeRequest = user.user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstName) \(lastName)"
                changeRequest.commitChanges { error in
                    guard let error = error else {
                        message = "\(user.user.displayName ?? "User") was sucessfully logged in."
                        self?.showAlertWith(message)
                        return
                    }
                    message = error.localizedDescription
                }
            } else {
                message = "There was an error.\n\(error?.localizedDescription ?? "")"
                self?.showAlertWith(message)
            }
        }
    }
    
    func showAlertWith(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
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
    
    func hideAndClearHintLabel() {
        emailHintLabel.text = ""
        passwordHintLabel.text = ""
        shouldShow(false, label: firstNameHintLabel)
        shouldShow(false, label: lastNameHintLabel)
        shouldShow(false, label: emailHintLabel)
        shouldShow(false, label: passwordHintLabel)
    }
}

