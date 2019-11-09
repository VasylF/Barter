//
//  File.swift
//  Barter
//
//  Created by Vasyl on 10/27/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import Foundation

enum ExtenedError: String, CustomStringConvertible, CaseIterable {
    
    case doNotContain8Symbols = "Enter 8 or more characters"
    case doNotContainDigit = "Enter at least 1 number"
    case doNotUpperLetter = "Enter at least 1 upper case letter"
    case doNotLowerLetter = "Enter at least 1 lower case letter"
    case extendedError = "Enter 8 or more characters, including 1 number, 1 upper case and 1 lower case letter"
    
    var description: String { return rawValue }
}

enum PasswordValidation: CustomStringConvertible {
    case extended(error: ExtenedError)
    case brief
    
    var description: String {
        switch self {
        case .extended(let error):
            return error.description
        case .brief:
            return "* Please enter at least 5 characters."
        }
    }
}
