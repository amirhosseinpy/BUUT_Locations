//
//  LocationsListView.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import UIKit

class LocationsListView: UIView {
  
  private(set) lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .systemBackground
    tableView.separatorStyle = .singleLine
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 40
    tableView.registerCell(type: LocationTableViewCell.self)
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    backgroundColor = .systemBackground
    addSubview(tableView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
