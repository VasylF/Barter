//
//  Constants+Firebase.swift
//  Barter
//
//  Created by Vasyl on 1/26/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

extension Constants.Firebase {
    struct Notifications {
        static let userDidLoginNotification = "UserDidLoginNotification"
        static let appStartedNotification = "AppStartedNotification"
    }
    
    struct FirebaseHeadersPath {
        static let user = "User"
        static let typing = "Typing"
        static let recent = "Recent"
        static let message = "Message"
        static let group = "Group"
        static let call = "Call"
    }
    
    struct User {
        static let currentUser = "currentUser"
        static let verificationCode = "firabase_verification"
        static let blockedUserID = "blockedUserID"
        static let facebook = "facebook"
        static let telegram = "telegram"
        static let viber = "viber"
        static let whatsApp = "whatsApp"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let fullName = "fullName"
        static let avatar = "avatar"
        static let isOnline = "isOnline"
        static let objectID = "objectID"
        static let pushID = "pushID"
        static let createdAt = "createdAt"
        static let updatedAt = "updatedAt"
        static let email = "email"
        static let phoneNumber = "phoneNumber"
        static let countryCode = "countryCode"
        static let country = "country"
        static let city = "city"
        static let loginMethods = "loginMethods"
        static let backgroundImage = "backgroundImage"
        static let showAvatar = "showAvatar"
        static let passwordProtect = "passwordProtect"
        static let firstRun = "firstRun"
        static let numberOfMessages = 10
        static let maxDiration = 120.0
        static let audioMaxDuration = 120.0
        static let success = 2
    }
    
    struct Chat {
        static let chartRoomID = "chartRoomID"
        static let userID = "userID"
        static let date = "date"
        static let privat = "privat"
        static let group = "group"
        static let groupID = "groupID"
        static let recentID = "recentID"
        static let members = "members"
        static let message = "message"
        static let membersToPush = "membersToPush"
        static let distriction = "distriction"
        static let lastMessage = "lastMessage"
        static let counter = "counter"
        static let type = "type"
        static let withUserUserName = "withUserUserName"
        static let withUserUserID = "withUserUserID"
        static let ownerID = "ownerID"
        static let status = "status"
        static let messageID = "messageID"
        static let name = "name"
        static let senderID = "senderID"
        static let senderName = "senderName"
        static let thumbnail = "thumbnail"
        static let isDeleted = "isDeleted"
    }
    
    struct Contacts {
        static let contact = "contact"
        static let contactID = "contactID"
    }
    
    struct MessageType {
        static let picture = "picture"
        static let text = "text"
        static let video = "video"
        static let audio = "audio"
        static let location = "location"
    }
    
    struct MessageStatus {
          static let deliveredError = "deliveredError"
          static let delivered = "delivered"
          static let read = "read"
          static let readDate = "readDate"
          static let deleted = "deleted"
      }
    
    struct Coordinates {
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    struct Push {
        static let deviceID = "deviceID"
    }
    
    struct Call {
        static let isIncoming = "isIncoming"
        static let callerID = "callerID"
        static let callerFullName = "callerFullName"
        static let callStatus = "callStatus"
        static let withUserFullName = "withUserFullName"
        static let callerAvatar = "callerAvatar"
        static let withUserAvatar = "withUserAvatar"
    }
  
}

public var recentBadgeHendler: ListenerRegistration?

