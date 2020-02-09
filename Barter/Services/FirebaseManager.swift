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

enum FirebaseError: Error {
    case updateUser
}

class FirebaseManager {
    static var currentUserID: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static var currentUser: FirebaseUser? {
        return UserDefaultsManager.currentUser
    }
    
    static func login(with email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completion(error)
                return
            }
            
            fetchUserFromFirestore(userID: user.user.uid)
            completion(nil)
        }
    }
    
    static func createProfile(for user: AuthDataResult, userInfo: (country: String, city: String, phone: String, avatar: String)) {
        let firebaseUser = FirebaseUser(firstName: user.user.displayName ?? "", lastName: "", objectID: user.user.uid, pushID: "", createdAt: Date(), updatedAt: Date(), email: user.user.email ?? "", phoneNumber: userInfo.phone, countryCode: "", country: userInfo.country, city: userInfo.city, loginMethods: K.Firebase.User.email)
        
        saveUserLocaly(user: firebaseUser)
        saveUserToFirestore(firebaseUser)
    }
    
    static func signInUser(with email: String, password: String, firstName: String, lastName: String, avatar: String = "", complition: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                complition(error)
                return
            }
            
            let firebaseUser = FirebaseUser(firstName: firstName, lastName: lastName, avatar: avatar, objectID: user.user.uid, pushID: "", createdAt: Date(), updatedAt: Date(), email: email, phoneNumber: "", countryCode: "", country: "", city: "", loginMethods: K.Firebase.User.email)
            
            //need to add methods
            
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
        guard let encodedUser = try? JSONEncoder().encode(user),
            let userJSON = try? JSONSerialization.jsonObject(with: encodedUser) as? [String: Any] else {
            LogService.log(module: .firebase, level: .error, "Cannot save user to Firebase")
            return
        }
        
        reference(.user).document(user.objectID).setData(userJSON) { error in
            LogService.log(module: .firebase, level: .error, error?.localizedDescription)
        }
    }
    
    static func saveUserLocaly(user: FirebaseUser) {
        guard let encodedUser = try? JSONEncoder().encode(user),
            let userJSON = try? JSONSerialization.jsonObject(with: encodedUser) as? [String: Any] else {
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
    
    static func updateCurrentUser(with values: [String: Any], completion: @escaping (Error?) -> Void) {
        if let userDictionary = UserDefaults.standard.object(forKey: K.Firebase.User.currentUser) {
            var tempValue = values
            let updatedAt = Date.formattedDate.string(from: Date())
            tempValue[K.Firebase.User.updatedAt] = updatedAt
            guard let userObject = (userDictionary as? NSDictionary)?.mutableCopy() as? NSMutableDictionary else {
                completion(FirebaseError.updateUser)
                return
            }
            
            userObject.setValuesForKeys(tempValue)
            
            reference(.user).document(currentUserID).updateData(values) { error in
                guard error == nil else {
                    completion(error)
                    return
                }
                
                UserDefaults.standard.save(userObject, for: .currentUser)
                completion(nil)
            }
            
        }
    }
}

private extension FirebaseManager {
    static func reference(_ collectionReference: FirebaseCollection) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
}
