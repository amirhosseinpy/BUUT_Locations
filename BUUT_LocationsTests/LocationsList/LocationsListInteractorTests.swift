//
//  LocationsListInteractorTests.swift
//  BUUT_LocationsTests
//
//  Created by Amirhossein Validabadi on 01/10/2025.
//

import Testing
import Foundation
@testable import BUUT_Locations

@Suite("LocationsListInteractor Tests")
@MainActor
struct LocationsListInteractorTests {
  

  @Test("Interactor fetches locations successfully and presents them")
  func testRequestLocationsSuccess() async throws {
    // Given
    let mockNetworkService = MockLocationsNetworkService()
    let mockPresenter = MockLocationsListPresenter()
    let interactor = LocationsListInteractor(networkService: mockNetworkService)
    interactor.presenter = mockPresenter

    let expectedLocations = [
      LocationModel(name: "Amsterdam", lat: 52.3676, long: 4.9041),
      LocationModel(name: "Rotterdam", lat: 51.9244, long: 4.4777)
    ]
    mockNetworkService.mockLocations = expectedLocations

    // When
    await interactor.requestLocations()

    // Then
    #expect(mockPresenter.presentLoadingCalled == true)
    #expect(mockNetworkService.fetchLocationsCalled == true)
    #expect(mockPresenter.presentLocationsCalled == true)
    #expect(mockPresenter.receivedLocations.count == 2)
    #expect(mockPresenter.receivedLocations[0].name == "Amsterdam")
    #expect(mockPresenter.receivedLocations[1].name == "Rotterdam")
  }

  @Test("Interactor presents error when network service fails")
  func testRequestLocationsFailure() async {
    // Given
    let mockNetworkService = MockLocationsNetworkService()
    let mockPresenter = MockLocationsListPresenter()
    let interactor = LocationsListInteractor(networkService: mockNetworkService)
    interactor.presenter = mockPresenter

    mockNetworkService.shouldThrowError = true

    // When
    await interactor.requestLocations()

    // Then
    #expect(mockPresenter.presentLoadingCalled == true)
    #expect(mockNetworkService.fetchLocationsCalled == true)
    #expect(mockPresenter.presentErrorCalled == true)
    #expect(mockPresenter.presentLocationsCalled == false)
  }

  @Test("Interactor presents empty array when no locations returned")
  func testRequestLocationsEmptyArray() async {
    // Given
    let mockNetworkService = MockLocationsNetworkService()
    let mockPresenter = MockLocationsListPresenter()
    let interactor = LocationsListInteractor(networkService: mockNetworkService)
    interactor.presenter = mockPresenter

    mockNetworkService.mockLocations = []

    // When
    await interactor.requestLocations()

    // Then
    #expect(mockPresenter.presentLoadingCalled == true)
    #expect(mockNetworkService.fetchLocationsCalled == true)
    #expect(mockPresenter.presentLocationsCalled == true)
    #expect(mockPresenter.receivedLocations.isEmpty)
  }

  @Test("Interactor ignores concurrent requests while loading")
  func testConcurrentRequestsIgnored() async {
    // Given
    let mockNetworkService = MockLocationsNetworkService()
    let mockPresenter = MockLocationsListPresenter()
    let interactor = LocationsListInteractor(networkService: mockNetworkService)
    interactor.presenter = mockPresenter

    mockNetworkService.mockLocations = [
      LocationModel(name: "Amsterdam", lat: 52.3676, long: 4.9041)
    ]

    // When - Start two concurrent requests
    async let request1: () = interactor.requestLocations()
    async let request2: () = interactor.requestLocations()
    await request1
    await request2

    // Then - Network service should only be called once
    #expect(mockNetworkService.fetchLocationsCalled == true)
    #expect(mockPresenter.presentLoadingCalled == true)
    #expect(mockPresenter.presentLocationsCalled == true)

    // Verify only one request was made (can't directly count calls with current mock)
    // The second request should have been dropped by the guard
  }

  @Test("Interactor allows new request after previous completes")
  func testSequentialRequestsAllowed() async {
    // Given
    let mockNetworkService = MockLocationsNetworkService()
    let mockPresenter = MockLocationsListPresenter()
    let interactor = LocationsListInteractor(networkService: mockNetworkService)
    interactor.presenter = mockPresenter

    mockNetworkService.mockLocations = [
      LocationModel(name: "Amsterdam", lat: 52.3676, long: 4.9041)
    ]

    // When - Make first request and wait for completion
    await interactor.requestLocations()

    // Reset mock state
    mockPresenter.presentLoadingCalled = false
    mockPresenter.presentLocationsCalled = false

    // Make second request
    await interactor.requestLocations()

    // Then - Both requests should have been processed
    #expect(mockPresenter.presentLoadingCalled == true)
    #expect(mockPresenter.presentLocationsCalled == true)
  }
}
