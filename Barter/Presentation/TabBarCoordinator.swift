//
//  TabBarCoordinator.swift
//  Barter
//
//  Created by Vasyl on 11/28/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit

class TabBarCoordinator: NSObject, ParentCoordinator {    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: RootCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeScreenViewController = HomeScreenViewController.instantiate()
        homeScreenViewController.coordinator = self
        navigationController.pushViewController(homeScreenViewController, animated: true)
    }
}

