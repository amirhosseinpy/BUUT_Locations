//
//  MockLocationsListPresenter.swift
//  BUUT_LocationsTests
//
//  Created by Amirhossein Validabadi on 01/10/2025.
//

import Foundation
@testable import BUUT_Locations

@MainActor
final class MockLocationsListPresenter: LocationsListPresentable {
  var presentLoadingCalled = false
  var presentLocationsCalled = false
  var presentErrorCalled = false
  var receivedLocations: [LocationModel] = []
  var receivedError: Error?

  func presentLoading() {
    presentLoadingCalled = true
  }

  func present(locations: [LocationModel]) {
    presentLocationsCalled = true
    receivedLocations = locations
  }

  func presentError(_ error: Error) {
    presentErrorCalled = true
    receivedError = error
  }
}
