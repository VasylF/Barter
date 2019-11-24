//
//  ResetPasswordViewController.swift
//  Barter
//
//  Created by Vasyl on 11/13/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var emailTextField: FloatLabelTextField!
    
    weak var coordinator: AuthenticationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func resetPasswordButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            guard error == nil else {
                self.showAlertWith(error?.localizedDescription ?? "Reset error", isError: true)
                return
            }
            
            self.showAlertWith("Please, check your email and click the secure link")
        })
        
    }
}

private extension ResetPasswordViewController {
    func showAlertWith(_ message: String, isError: Bool = false) {
        let alert = UIAlertController(title: "Reset Password", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
