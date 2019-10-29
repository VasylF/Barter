//
//  Font.swift
//  Barter
//
//  Created by Vasyl on 9/28/19.
//

import Foundation

extension Constants.Font {
    
    enum FontName: String, FontRepresentable {
        case regular = "Arial"
        case bold = "Arial-Bold"
    }
    
    struct TextField {
        static let font = K.Font.FontName.regular.of(size: 13)
    }
}
