//
//  LocationsListInteractor.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import Foundation

protocol LocationsListInteractable: AnyObject {
  func requestLocations() async
}

@MainActor
class LocationsListInteractor: LocationsListInteractable {
  var presenter: LocationsListPresentable?
  var networkService: LocationsNetworkServicable
  private var isLoading: Bool = false // to prevent multiple reqeust to server and race condition safe

  init(networkService: LocationsNetworkServicable) {
    self.networkService = networkService
  }

  func requestLocations() async {
    guard !isLoading else { return }

    isLoading = true
    presenter?.presentLoading()
    do {
      let locations = try await networkService.fetchLocations()
      presenter?.present(locations: locations)
      isLoading = false
    } catch {
      presenter?.presentError(error)
      isLoading = false
    }
  }
}

