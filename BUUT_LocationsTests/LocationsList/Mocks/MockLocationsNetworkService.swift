//
//  MockLocationsNetworkService.swift
//  BUUT_LocationsTests
//
//  Created by Amirhossein Validabadi on 01/10/2025.
//

import Foundation
@testable import BUUT_Locations

final class MockLocationsNetworkService: LocationsNetworkServicable {
  var shouldThrowError = false
  var mockLocations: [LocationModel] = []
  var fetchLocationsCalled = false

  func fetchLocations() async throws -> [LocationModel] {
    fetchLocationsCalled = true
    if shouldThrowError {
      throw URLError(.badServerResponse)
    }
    return mockLocations
  }
}
