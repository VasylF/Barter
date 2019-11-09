//
//  PasswordValidator.swift
//  Barter
//
//  Created by Vasyl on 10/26/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import Foundation

struct ExtenededPasswordValidator {
    
    private let password: String?
    
    init(_ password: String?) {
        self.password = password
    }
    
    // MARK: -
    // MARK: - Validator protocol
    var errors: [PasswordValidation] {
        guard let password = password else { return [.extended(error: .extendedError)] }
        var items: [PasswordValidation] = []
        if !password.conains8Symbols {
            items.append(.extended(error: .doNotContain8Symbols))
        }
        if !password.containsUpperLetter {
            items.append(.extended(error: .doNotUpperLetter))
        }
        if !password.containsDigit {
            items.append(.extended(error: .doNotContainDigit))
        }
        if !password.containsLowerLetter{
            items.append(.extended(error: .doNotLowerLetter))
        }
        return items
    }
}

