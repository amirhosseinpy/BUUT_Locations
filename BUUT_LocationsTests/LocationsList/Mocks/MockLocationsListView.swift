//
//  MockLocationsListView.swift
//  BUUT_LocationsTests
//
//  Created by Amirhossein Validabadi on 01/10/2025.
//

import Foundation
@testable import BUUT_Locations

final class MockLocationsListView: LocationsListViewable {
  var showLocationsCalled = false
  var showErrorCalled = false
  var showLoadingCalled = false
  var hideLoadingCalled = false
  var receivedLocations: [LocationViewModel] = []
  var receivedErrorMessage: String?

  func show(locations: [LocationViewModel]) {
    showLocationsCalled = true
    receivedLocations = locations
  }

  func showError(message: String) {
    showErrorCalled = true
    receivedErrorMessage = message
  }

  func showLoading() {
    showLoadingCalled = true
  }

  func hideLoading() {
    hideLoadingCalled = true
  }
}
