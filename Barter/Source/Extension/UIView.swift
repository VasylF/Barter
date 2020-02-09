//
//  UIView.swift
//  Barter
//
//  Created by Vasyl on 10/26/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit

extension UIView {
    func hide(superView: UIView? = nil) {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = true
            self.superview?.layoutIfNeeded()
        }
    }
    
    func show(superView: UIView? = nil) {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = false
            self.superview?.layoutIfNeeded()
        }
    }
}
