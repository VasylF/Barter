//
//  LogService.swift
//  Barter
//
//  Created by Vasyl on 2/1/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import Foundation

enum LogModule: String {
    case application = "Application"
    case apiUsage = "API"
    case userDefaults = "UserDefaults"
    case reachability = "Reachability Service"
    case firebase = "Firebase"
}

enum LogLevel: Int {
    case error
    case debug
    case worning
    case none
}

class LogService {
    private static var verbosityLevel: LogLevel = .debug
    private static var moduleLevels: [LogModule: LogLevel] = [:]
    
    public static func setGlobalVerbosityLevel(level: LogLevel) {
        verbosityLevel = level
    }
    
    public static func setVerbosityLevel(level: LogLevel, for module: LogModule) {
        moduleLevels[module] = level
    }
    
    public static func verbosityLevel(for module: LogModule) -> LogLevel {
        return moduleLevels[module] ?? self.verbosityLevel
    }
    
    public static func log(module: LogModule, level: LogLevel, _ item: Any) {
        guard level != .none, verbosityLevel(for: module).rawValue >= level.rawValue else {
            return
        }
        
        print("[\(module.rawValue)]", item)
    }
}

