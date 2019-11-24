//
//  Coordinator.swift
//  Barter
//
//  Created by Vasyl on 11/24/19.
//  Copyright © 2019 VasylFuchenko. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
