//
//  CircleButton.swift
//  Barter
//
//  Created by Vasyl on 2/4/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        commonInIt()
        setBackgroundImage(.checkmark, for: .selected)
    }
    
    override public var isHighlighted: Bool {
        didSet {
            self.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
    }
    
    private func commonInIt() {
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.red.cgColor
        clipsToBounds = true
    }
}

//extension CircleButton {
//    @IBInspectable var selectedColor: UIColor? {
//        set {
//            guard let color = newValue else { return }
//            backgroundColor = color
//        }
//        get {
//            guard let color = backgroundColor else { return nil }
//            return color
//        }
//    }
//
//    @IBInspectable var disabledColor: UIColor? {
//          set {
//              guard let color = newValue else { return }
//              backgroundColor = color
//          }
//          get {
//              guard let color = backgroundColor else { return nil }
//              return color
//          }
//      }
//    
//}
