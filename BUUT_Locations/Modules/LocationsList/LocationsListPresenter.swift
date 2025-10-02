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
  func presentLoading()
  func present(locations: [LocationModel])
  func presentError(_ error: Error)
}

class LocationsListPresenter: LocationsListPresentable {
  weak var view: LocationsListViewable?

  func presentLoading() {
    view?.showLoading()
  }

  func present(locations: [LocationModel]) {
    view?.hideLoading()
    let viewModels: [LocationViewModel] = locations.map { location in
      let locationViewModel = LocationViewModel(
        name: location.name ?? "No Name",
        coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long))
      return locationViewModel
    }
    view?.show(locations: viewModels)
  }

  func presentError(_ error: Error) {
    view?.hideLoading()
    let errorMessage: String
    if let urlError = error as? URLError {
      switch urlError.code {
      case .notConnectedToInternet:
        errorMessage = "No internet connection. Please check your network settings."
      case .timedOut:
        errorMessage = "The request timed out. Please try again."
      case .badURL:
        errorMessage = "Invalid URL. Please contact support."
      case .badServerResponse:
        errorMessage = "Server error. Please try again later."
      default:
        errorMessage = "Network error: \(urlError.localizedDescription)"
      }
    } else {
      errorMessage = "Failed to load locations: \(error.localizedDescription)"
    }
    view?.showError(message: errorMessage)
  }
}
