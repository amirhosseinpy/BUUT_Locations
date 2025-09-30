//
//  UITableView+Extension.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import UIKit

protocol Reusable: AnyObject {}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableView {
  func dequeueCell<R: Reusable>(for indexPath: IndexPath) -> R {
    guard let cell = dequeueReusableCell(withIdentifier: R.reuseIdentifier, for: indexPath) as? R else {
      fatalError("\(R.reuseIdentifier) is not registered")
    }
    return cell
  }
  
  func registerCell(type: Reusable.Type) {
    register(type.self, forCellReuseIdentifier: type.reuseIdentifier)
  }
}
