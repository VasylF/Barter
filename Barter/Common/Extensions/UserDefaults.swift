//
//  UserDefaults.swift
//  Barter
//
//  Created by Vasyl on 2/1/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import Foundation

extension UserDefaults {
  
    func save(_ object: Any, for key: UserDefaultKey) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}
