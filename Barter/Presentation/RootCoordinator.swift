//
//  RootCoordinator.swift
//  Barter
//
//  Created by Vasyl on 11/27/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit


protocol ParentCoordinator: Coordinator {
    var parentCoordinator: RootCoordinator? { get set }
}
class RootCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    var isAuth = false
    
    init(_ navController: UINavigationController) {
        navigationController = navController
    }
    
    func start() {
        let child: ParentCoordinator = isAuth ? TabBarCoordinator(navigationController)
                                        : AuthenticationCoordinator(navigationController)
        
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func navigateToHomeScreen(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
        navigationController.viewControllers.removeAll()
        let tabBarCoordinator = TabBarCoordinator(navigationController)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.parentCoordinator = self
        tabBarCoordinator.start()
    }
}

extension RootCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
    
}

