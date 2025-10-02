//
//  LocationsListViewController.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import UIKit

protocol LocationsListViewable: AnyObject {
  func show(locations: [LocationViewModel])
  func showError(message: String)
  func showLoading()
  func hideLoading()
}

extension LocationsListViewController {
  enum Constants {
    static let title = "Locations"
  }
}

class LocationsListViewController: UIViewController {
  var interactor: LocationsListInteractable?
  private(set) var items: [LocationViewModel] = []

  private var customView: LocationsListView {
    return view as! LocationsListView
  }

  override func loadView() {
    view = LocationsListView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupTableView()
    fetchData()
  }

  private func setupUI() {
    title = Constants.title
  }

  private func setupTableView() {
    customView.tableView.delegate = self
    customView.tableView.dataSource = self
  }
  
  private func fetchData() {
    Task {
      await interactor?.requestLocations()
    }
  }
}

extension LocationsListViewController: LocationsListViewable {
  func show(locations: [LocationViewModel]) {
    self.items = locations
    customView.errorLabel.isHidden = true
    customView.tableView.isHidden = false
    customView.tableView.reloadData()
  }

  func showError(message: String) {
    customView.errorLabel.text = message
    customView.errorLabel.isHidden = false
    customView.tableView.isHidden = true
  }
  
  func showLoading() {
    customView.loadingIndicator.startAnimating()
    customView.tableView.isHidden = true
    customView.errorLabel.isHidden = true
  }

  func hideLoading() {
    customView.loadingIndicator.stopAnimating()
  }
}

// this part also can happen in a tableViewProvider if our viewController is getting big
extension LocationsListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: LocationTableViewCell = tableView.dequeueCell(for: indexPath)
    cell.configure(with: items[indexPath.row])
    return cell
  }
}

