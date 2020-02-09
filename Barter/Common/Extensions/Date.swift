//
//  Date.swift
//  Barter
//
//  Created by Vasyl on 2/1/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import Foundation

extension Date {
    static var formattedDate: DateFormatter {
        let dateFormat = "yyyyMMddHHmss"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter
    }
}
