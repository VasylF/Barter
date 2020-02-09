//
//  UIImage.swift
//  Barter
//
//  Created by Vasyl on 2/9/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import UIKit

extension UIImage {
    var imageString: String? {
        let imageIMG = jpegData(compressionQuality: 0.7)
        return imageIMG?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
}
