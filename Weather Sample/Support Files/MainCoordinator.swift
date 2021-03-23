//
//  MainCoordinator.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 23/3/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainTableViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    func searchCities() {
        let vc = SearchCityVC.instantiate()
        vc.coordinator = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        navigationController.present(nav, animated: true, completion: nil)
    }
    
    func showWeatherDetailed(data: TypeOfDataToDetailedVC)  {
        let vc = DetailedWeatherVC.instantiate()
        vc.coordinator = self
        vc.passedData = data
        navigationController.pushViewController(vc, animated: true)
    }

}
