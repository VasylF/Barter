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

    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        for view in view.subviews where view is UIActivityIndicatorView {
            view.removeFromSuperview()
        }
    }
}
