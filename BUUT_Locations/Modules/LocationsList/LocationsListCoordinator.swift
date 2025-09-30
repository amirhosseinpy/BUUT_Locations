//
//  LocationsListCoordinator.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import UIKit

protocol Coordinatable {
  var childCoordinators: [Coordinatable] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()
}

class LocationsListCoordinator: Coordinatable {
  var childCoordinators: [any Coordinatable] = []
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let interactor = LocationsListInteractor()
    let presenter = LocationsListPresenter()
    let viewController = LocationsListViewController()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.view = viewController
    
    navigationController.pushViewController(viewController, animated: false)
  }
}
