//
//  UIViewController.swift
//  Barter
//
//  Created by Vasyl on 11/9/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit


extension UIViewController {
    func hideKeyboardOnTap() {
        weak var weakSelf = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: weakSelf, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
