//
//  LocationsNetworkService.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import Foundation

protocol LocationsNetworkServicable {
  func fetchLocations() async throws -> [LocationModel]
}

extension LocationsNetworkService {
  enum Constants {
    static let urlString = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
  }
}

class LocationsNetworkService: LocationsNetworkServicable {
  private let decoder: JSONDecoder
  private let urlSession: URLSession
  
  init(urlSession: URLSession = .shared, decoder: JSONDecoder = .init()) {
    self.decoder = decoder
    self.urlSession = urlSession
  }
  
  
  // This is a simple fetch request. If we have time we can make a base request class using Generic for request and response and able to add token and throw more meaningful errors.
  
  func fetchLocations() async throws -> [LocationModel] {
    guard let url = URL(string: Constants.urlString) else {
      throw URLError(.badURL)
    }
    
    let (data, _) = try await urlSession.data(from: url)
    let locations = try decoder.decode(LocationsModel.self, from: data)
    return locations.locations
  }
}
