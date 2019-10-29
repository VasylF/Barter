//
//  FontRepresentable.swift
//  Barter
//
//  Created by Vasyl on 9/28/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit

public protocol FontRepresentable: RawRepresentable {}

extension FontRepresentable where Self.RawValue == String {

    public func of(size: CGFloat) -> UIFont {
        return font(name: rawValue, size: size)
    }

    public func of(size: Int) -> UIFont {
        return font(name: rawValue, size: CGFloat(size))
    }

    public func of(size: Double) -> UIFont {
        return font(name: rawValue, size: CGFloat(size))
    }
    
    private func font(name: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: rawValue, size: size) {
            return font
        } else {
            let message = "Can't initialize UIFont with name \(name)"
            #if DEBUG
                fatalError(message)
            #else
                return UIFont.systemFont(ofSize: size)
            #endif
        }
    }
}
