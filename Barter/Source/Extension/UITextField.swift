//
//  TextField.swift
//  Barter
//
//  Created by Vasyl on 10/26/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit

extension UITextField {
    func configure(cornerRadius: CGFloat = 3, borderWidth: CGFloat = 2) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 3
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.red.cgColor
    }
}


