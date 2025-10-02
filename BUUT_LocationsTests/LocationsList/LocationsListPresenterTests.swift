//
//  LocationsListPresenterTests.swift
//  BUUT_LocationsTests
//
//  Created by Amirhossein Validabadi on 01/10/2025.
//

import Testing
import Foundation
import CoreLocation
@testable import BUUT_Locations

@Suite("LocationsListPresenter Tests")
@MainActor
struct LocationsListPresenterTests {

  @Test("Presenter transforms locations to view models and shows them")
  func testPresentLocationsSuccess() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    let locations = [
      LocationModel(name: "Amsterdam", lat: 52.3676, long: 4.9041),
      LocationModel(name: "Rotterdam", lat: 51.9244, long: 4.4777)
    ]

    // When
    presenter.present(locations: locations)

    // Then
    #expect(mockView.hideLoadingCalled == true)
    #expect(mockView.showLocationsCalled == true)
    #expect(mockView.receivedLocations.count == 2)
    #expect(mockView.receivedLocations[0].name == "Amsterdam")
    #expect(mockView.receivedLocations[0].coordinate.latitude == 52.3676)
    #expect(mockView.receivedLocations[0].coordinate.longitude == 4.9041)
    #expect(mockView.receivedLocations[1].name == "Rotterdam")
    #expect(mockView.receivedLocations[1].coordinate.latitude == 51.9244)
    #expect(mockView.receivedLocations[1].coordinate.longitude == 4.4777)
  }

  @Test("Presenter handles location with nil name by using default")
  func testPresentLocationWithNilName() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    let locations = [
      LocationModel(name: nil, lat: 52.3676, long: 4.9041)
    ]

    // When
    presenter.present(locations: locations)

    // Then
    #expect(mockView.showLocationsCalled == true)
    #expect(mockView.receivedLocations.count == 1)
    #expect(mockView.receivedLocations[0].name == "No Name")
  }

  @Test("Presenter handles empty locations array")
  func testPresentEmptyLocations() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    let locations: [LocationModel] = []

    // When
    presenter.present(locations: locations)

    // Then
    #expect(mockView.showLocationsCalled == true)
    #expect(mockView.receivedLocations.isEmpty)
  }

  @Test("Presenter handles multiple locations with mixed names")
  func testPresentMixedLocations() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    let locations = [
      LocationModel(name: "Amsterdam", lat: 52.3676, long: 4.9041),
      LocationModel(name: nil, lat: 51.9244, long: 4.4777),
      LocationModel(name: "Utrecht", lat: 52.0907, long: 5.1214)
    ]

    // When
    presenter.present(locations: locations)

    // Then
    #expect(mockView.showLocationsCalled == true)
    #expect(mockView.receivedLocations.count == 3)
    #expect(mockView.receivedLocations[0].name == "Amsterdam")
    #expect(mockView.receivedLocations[1].name == "No Name")
    #expect(mockView.receivedLocations[2].name == "Utrecht")
  }

  @Test("Presenter shows loading state")
  func testPresentLoading() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    // When
    presenter.presentLoading()

    // Then
    #expect(mockView.showLoadingCalled == true)
  }

  @Test("Presenter presents error with meaningful message")
  func testPresentError() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    let error = URLError(.notConnectedToInternet)

    // When
    presenter.presentError(error)

    // Then
    #expect(mockView.hideLoadingCalled == true)
    #expect(mockView.showErrorCalled == true)
    #expect(mockView.receivedErrorMessage == "No internet connection. Please check your network settings.")
  }

  @Test("Presenter handles badURL error")
  func testPresentBadURLError() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    let error = URLError(.badURL)

    // When
    presenter.presentError(error)

    // Then
    #expect(mockView.hideLoadingCalled == true)
    #expect(mockView.showErrorCalled == true)
    #expect(mockView.receivedErrorMessage == "Invalid URL. Please contact support.")
  }

  @Test("Presenter handles timeout error")
  func testPresentTimeoutError() {
    // Given
    let mockView = MockLocationsListView()
    let presenter = LocationsListPresenter()
    presenter.view = mockView

    let error = URLError(.timedOut)

    // When
    presenter.presentError(error)

    // Then
    #expect(mockView.hideLoadingCalled == true)
    #expect(mockView.showErrorCalled == true)
    #expect(mockView.receivedErrorMessage == "The request timed out. Please try again.")
  }
}
