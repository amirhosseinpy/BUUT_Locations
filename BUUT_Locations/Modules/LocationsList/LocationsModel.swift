//
//  LocationsModel.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import Foundation
import CoreLocation

struct LocationsModel: Codable {
  var locations: [LocationModel]
}

struct LocationModel: Codable {
  let name: String?
  let lat: Double
  let long: Double
}

struct LocationViewModel {
  let name: String
  let coordinate: CLLocationCoordinate2D
}
