//
//  Coordinator.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 23/3/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
