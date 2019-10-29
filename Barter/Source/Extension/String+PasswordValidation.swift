//
//  String+PasswordValidation.swift
//  Barter
//
//  Created by Vasyl on 10/23/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import Foundation

extension String {
    
    enum RegexType: String, CustomStringConvertible {
        case conains8Symbols = ".{8,}"
        case containsUpperLetter = ".*[A-Z].*"
        case containsLowerLetter = ".*[a-z].*"
        case containsDigit = ".*[0-9].*"
        case containsSymbol = ".*[$@*()#!%?&.,].*"
        
        var description: String { return rawValue }
    }
    
    var containsSymbol: Bool { // any symbol
        return evaluate(regex: .containsSymbol)
    }
    
    var conains8Symbols: Bool { // 8 or more symbols
        return evaluate(regex: .conains8Symbols)
    }
    
    var containsUpperLetter: Bool { // use positive look ahead to see if at least one upper case letter exists
        return evaluate(regex: .containsUpperLetter)
    }
    
    var containsLowerLetter: Bool { // use positive look ahead to see if at least one lower case letter exists
        return evaluate(regex: .containsLowerLetter)
    }
    
    var containsDigit: Bool { // use positive look ahead to see if at least one digit
        return evaluate(regex: .containsDigit)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
}

private extension String {
    func evaluate(regex: RegexType) -> Bool {
        let regEx = regex.description
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
}
