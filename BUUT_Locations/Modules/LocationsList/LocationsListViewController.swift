//
//  LocationsListViewController.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import UIKit

protocol LocationsListViewable {
  
}

class LocationsListViewController: UIViewController, LocationsListViewable {
  var interactor: LocationsListInteractable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  private func setupUI() {
    title = "Locations"
    view.backgroundColor = .systemBackground
  }
}

