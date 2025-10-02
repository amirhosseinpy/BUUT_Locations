//
//  LocationTableViewCell.swift
//  BUUT_Locations
//
//  Created by Amirhossein Validabadi on 30/09/2025.
//

import UIKit
internal import _LocationEssentials


class LocationTableViewCell: UITableViewCell, Reusable {
  enum Constants {
    static let coordinateFormat = "%.4f, %.4f"
  }
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: UIFont.Size.subtitle, weight: .semibold)
    label.textColor = .label
    label.numberOfLines = 1
    return label
  }()
  
  private let coordinatesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: UIFont.Size.body, weight: .regular)
    label.textColor = .tertiaryLabel
    label.numberOfLines = 1
    return label
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = CGFloat.Spacing.small
    stackView.alignment = .leading
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupCell()
  }
  
  private func setupCell() {
    selectionStyle = .default
    
    stackView.addArrangedSubview(nameLabel)
    stackView.addArrangedSubview(coordinatesLabel)
    
    contentView.addSubview(stackView)
    
    // Mostly, I use SnapKit to make constraints, but here I did not want to add any dependencies
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat.Spacing.medium),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat.Spacing.medium),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CGFloat.Spacing.medium),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CGFloat.Spacing.medium)
    ])
  }
  
  func configure(with location: LocationViewModel) {
    nameLabel.text = location.name
    coordinatesLabel.text = unsafe String(format: Constants.coordinateFormat, location.coordinate.latitude, location.coordinate.longitude)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    coordinatesLabel.text = nil
  }
}
