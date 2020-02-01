//
//  UserDefaultsManager.swift
//  Barter
//
//  Created by Vasyl on 2/1/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    static var currentUser: FirebaseUser? {
        guard let data = UserDefaults.standard.object(forKey: UserDefaultKey.currentUser.rawValue) as? Data else { return nil }
        do {
            return try JSONDecoder().decode(FirebaseUser.self, from: data)
        } catch let error {
            LogService.log(module: .userDefaults, level: .error, error.localizedDescription)
            return nil
        }
    }
}
