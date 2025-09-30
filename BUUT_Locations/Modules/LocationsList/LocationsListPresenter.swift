//
//  LocationsListPresenter.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import Foundation
import CoreLocation

@MainActor
protocol LocationsListPresentable {
  func present(locations: [LocationModel])
}

class LocationsListPresenter: LocationsListPresentable {
  weak var view: LocationsListViewable?
  
  func present(locations: [LocationModel]) {
    let viewModels: [LocationViewModel] = locations.map { location in
      let locationViewModel = LocationViewModel(
        name: location.name ?? "No Name",
        coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long))
      return locationViewModel
    }
    view?.show(locations: viewModels)
  }
}
