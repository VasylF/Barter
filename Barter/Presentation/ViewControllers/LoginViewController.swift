//
//  LoginViewController.swift
//  Barter
//
//  Created by Vasyl on 9/21/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//
import UIKit
import SwiftUI
import ACFloatingTextfield_Swift

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: ACFloatingTextfield!
    @IBOutlet weak var passwordTextField: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.configure()
        passwordTextField.configure()
    }
    
    private func configureTextFields() {
//        emailTextField.coefficientForFloatLabelHeight = 5
//        emailTextField.coefficientForYPosition == 11
//        emailTextField
    }

}
