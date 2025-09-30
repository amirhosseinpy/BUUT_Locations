//
//  LocationsListInteractor.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import Foundation


protocol LocationsListInteractable: AnyObject {
  func requestLocations() async throws
}

class LocationsListInteractor: LocationsListInteractable {
  var presenter: LocationsListPresentable?
  var networkService: LocationsNetworkServicable
  
  init(networkService: LocationsNetworkServicable) {
    self.networkService = networkService
  }
  
  func requestLocations() async throws {
    let locations = try await networkService.fetchLocations()
    presenter?.present(locations: locations)
  }
}

