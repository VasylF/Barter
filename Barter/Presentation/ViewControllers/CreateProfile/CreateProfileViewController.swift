//
//  CreateProfileViewController.swift
//  Barter
//
//  Created by Vasyl on 2/2/20.
//  Copyright © 2020 VasylFuchenko. All rights reserved.
//

import UIKit
import Firebase

private typealias Const = K.Firebase.User
class CreateProfileViewController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var cityTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var manButton: CircleButton!
    @IBOutlet private weak var womanButton: CircleButton!
    @IBOutlet private weak var doneButton: UIButton!
    
    var user: AuthDataResult?
    
    weak var coordinator: AuthenticationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGestureForImage()
    }
    
    // MARK: - IBAction
    
    @IBAction func doneButtonDidPressed(_ sender: Any) {
        let userInfo: (country: String, city: String, phone: String, avatar: String)
        guard let country = countryTextField.text, !country.isEmpty,
            let city = cityTextField.text, !city.isEmpty, let phone =  phoneNumberTextField.text, !phone.isEmpty else { return }
        userInfo = (country, city, phone, "")
        
        FirebaseManager.createProfile(for: user!, userInfo: userInfo)
    }
    
    @IBAction func cencelButtonDidPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func manButtonPressed(_ sender: Any) {
        manButton.backgroundColor = manButton.backgroundColor == .green ? .clear : .green
    }
    
    @IBAction func womanButtonPressed(_ sender: Any) {
        womanButton.backgroundColor = womanButton.backgroundColor == .green ? .clear : .green
    }
    
    @objc func avatarImageViewDidPressed() {
        
    }
}

private extension CreateProfileViewController {
    func addTapGestureForImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarImageViewDidPressed))
        avatarImageView.addGestureRecognizer(tapGesture)
        avatarImageView.isUserInteractionEnabled = true
    }
    
    func registerUser() {
        var tempDictionary: Dictionary = [
            Const.fullName: user?.user.displayName,
            Const.country: countryTextField.text,
            Const.city: cityTextField.text,
            Const.phoneNumber: phoneNumberTextField.text
        ]
        
        if avatarImageView.image == nil {
            if let image = imageFromInitials() {
                tempDictionary[Const.avatar] = image.imageString
            }
        } else {
            tempDictionary[Const.avatar] = avatarImageView.image?.imageString
        }
        finishRegistration(with: tempDictionary)
    }
    
    func finishRegistration(with dictionary: [String: Any]) {
        FirebaseManager.updateCurrentUser(with: dictionary) { error in
            guard error == nil else {
                // TODO: Show alert error
                return
            }
            
        }
    }
    
    func imageFromInitials() -> UIImage? {
        var initials: String
        if let fullName = user?.user.displayName {
            let splitedName = fullName.components(separatedBy: " ")
            initials = (splitedName.first?.first?.uppercased() ?? "") + (splitedName.last?.first?.uppercased() ?? "")
        } else {
            initials = "NS"
        }
        
        let initialsLabel = UILabel()
        initialsLabel.frame.size = avatarImageView.frame.size
        initialsLabel.textColor = .black
        initialsLabel.font = UIFont(name: "Futura",
                                size: avatarImageView.frame.size.height / 2)
        initialsLabel.text = initials
        initialsLabel.textAlignment = .center
        initialsLabel.backgroundColor = .lightGray
        initialsLabel.layer.cornerRadius = avatarImageView.frame.size.height / 2
        initialsLabel.clipsToBounds = true
        UIGraphicsBeginImageContext(initialsLabel.frame.size)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        initialsLabel.layer.render(in: currentContext)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        return image
    }
}
