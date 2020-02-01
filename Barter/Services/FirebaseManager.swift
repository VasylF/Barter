//
//  FirebaseManager.swift
//  Barter
//
//  Created by Vasyl on 2/1/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager {
    static var currentUserID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    static var currentUser: FirebaseUser? {
        return UserDefaultsManager.currentUser
    }
    
    static func login(with email: String, and password: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completion(error)
                return
            }
            
            //user fetching
            completion(nil)
        }
    }
    
    static func signInUser(with email: String, password: String, firstName: String, lastName: String, avatar: String = "", complition: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                complition(error)
                return
            }
            
            let firebaseUser = FirebaseUser(firstName: firstName, lastName: lastName, avatar: avatar, objectID: user.user.uid, pushID: "", createdAt: Date(), updatedAt: Date(), email: email, phoneNumber: "", countryCode: "", country: "", city: "", loginMethods: K.Firebase.User.email)
            
            //methods
            
            complition(nil)
        }
    }
    
    static func logoutCurrentUser(complition: @escaping (_ success: Bool) -> Void) {
        //user defaults
        
        do {
            try Auth.auth().signOut()
            complition(true)
        } catch let error {
            LogService.log(module: .firebase, level: .error,
                           error.localizedDescription)
            complition(false)
        }
    }
    
    static func deleteCurrentUser(complition: @escaping (_ error: Error?) -> Void) {
        Auth.auth().currentUser?.delete(completion: { error in
            complition(error)
        })
    }
    
    static func saveUserToFirestore(_ user: FirebaseUser) {
        guard let encodedUser = try? JSONEncoder().encode(user), let userJSON = encodedUser.encodedDictionary else {
            LogService.log(module: .firebase, level: .error, "Cannot encode user")
            return
        }
        
        reference(.user).document(user.objectID).setData(userJSON) { error in
            LogService.log(module: .firebase, level: .error, error?.localizedDescription)
        }
    }
    
    static func saveUserLocaly(user: FirebaseUser) {
        guard let encodedUser = try? JSONEncoder().encode(user), let userJSON = encodedUser.encodedDictionary else {
                  LogService.log(module: .firebase, level: .error, "Cannot save user localy")
                  return
              }
        UserDefaults.standard.save(userJSON, for: .currentUser)
    }
    
    static func fetchUserFromFirestore(userID: String) {
        reference(.user).document(userID).getDocument { (snapshot, error) in
            guard let snapshot = snapshot, snapshot.exists, let snapshodData = snapshot.data() else {
                LogService.log(module: .firebase, level: .error, "Snapshot is nill or doesn't exist.")
                return
            }
            
            UserDefaults.standard.save(snapshodData, for: .currentUser)
        }
    }
}

private extension FirebaseManager {
    static func reference(_ collectionReference: FirebaseCollection) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
}
