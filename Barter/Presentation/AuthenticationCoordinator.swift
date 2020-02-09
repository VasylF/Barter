//
//  AuthenticationCoordinator.swift
//  Barter
//
//  Created by Vasyl on 11/24/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit
import Firebase

class AuthenticationCoordinator: NSObject, ParentCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: RootCoordinator?
    
    init(_ navController: UINavigationController) {
        navigationController = navController
    }
    
    func start() {
        let logInViewController = LoginViewController.instantiate()
        logInViewController.coordinator = self
        navigationController.pushViewController(logInViewController, animated: true)
        navigationController.delegate = self
    }
    
    func resetPassword() {
        let resetPasswordViewController = ResetPasswordViewController.instantiate()
        resetPasswordViewController.coordinator = self
        navigationController.present(resetPasswordViewController, animated: true, completion: nil)
    }
    
    func createAccount() {
        let signInViewController = SignInViewController.instantiate()
        signInViewController.coordinator = self
        navigationController.pushViewController(signInViewController, animated: true)
    }
    
    func createProfile(for user: AuthDataResult?) {
        let createProfileViewController = CreateProfileViewController.instantiate()
        createProfileViewController.coordinator = self
        createProfileViewController.user = user
        navigationController.present(createProfileViewController, animated: true, completion: nil)
    }
    
    func navigateToHomeScreen() {
        parentCoordinator?.navigateToHomeScreen(self)
    }
}

extension AuthenticationCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        //           guard let buyViewController = fromViewController as? BuyViewController else {
        //               return
        //           }
        //
        //           childDidFinish(buyViewController.coordinator)
    }
    
}
