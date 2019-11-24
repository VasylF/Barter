//
//  Storyboarded.swift
//  Barter
//
//  Created by Vasyl on 11/24/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let className = NSStringFromClass(self).components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateViewController(identifier: className) as! Self
    }
}
