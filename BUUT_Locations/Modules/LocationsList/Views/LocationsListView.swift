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

  private(set) lazy var errorLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: UIFont.Size.subtitle, weight: .medium)
    label.textColor = .systemRed
    label.isHidden = true
    return label
  }()

  private(set) lazy var loadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    indicator.color = .systemGray
    return indicator
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

    setupTableView()
    setupErrorLabel()
    setupLoadingIndicator()
  }
  
  private func setupTableView() {
    addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
  
  private func setupErrorLabel() {
    addSubview(errorLabel)
    NSLayoutConstraint.activate([
      errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.Spacing.medium),
      errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.Spacing.medium)
    ])
  }

  private func setupLoadingIndicator() {
    addSubview(loadingIndicator)
    NSLayoutConstraint.activate([
      loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
