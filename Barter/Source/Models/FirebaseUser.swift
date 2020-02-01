//
//  FirebaseUser.swift
//  Barter
//
//  Created by Vasyl on 1/26/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseUser: Codable {
    var firstName: String
    var lastName: String
    var fullName: String
    var avatar: String
    
    var isOnline: Bool
    
    let objectID: String
    var pushID: String?
    
    let createdAt: Date
    var updatedAt: Date
    
    var email: String
    var phoneNumber: String
    var countryCode: String
    var country: String
    var city: String
    
    var contacts: [String]
    var blockedContacts: [String]
    let loginMethods: String
    
    // Mark: - initializars
    
    init(firstName: String, lastName: String, avatar: String = "", objectID: String, pushID: String?, createdAt: Date, updatedAt: Date, email: String,
        phoneNumber: String, countryCode: String, country: String,
        city: String, loginMethods: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName + " " + lastName
        self.avatar = avatar
        self.isOnline = true
        self.objectID = objectID
        self.pushID = pushID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.email = email
        self.phoneNumber = phoneNumber
        self.countryCode = ""
        self.country = country
        self.city = city
        self.loginMethods = loginMethods
        self.blockedContacts = []
        self.contacts = []
    }
}
