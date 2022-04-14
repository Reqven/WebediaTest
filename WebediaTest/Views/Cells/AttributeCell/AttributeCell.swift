//
//  DetailCell.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import UIKit

class AttributeCell: UITableViewCell {
  
  //MARK: - Properties
  static let reusableIdentifier = "AttributeCell"
  
  var viewModel: AttributeCellViewModel? {
    didSet { updateView() }
  }

  //MARK: - Methods
  func configure(with viewModel: AttributeCellViewModel) {
    self.viewModel = viewModel
  }
  
  func updateView() {
    guard let model = viewModel else { return }
    textLabel?.text = model.name
    detailTextLabel?.text = model.value
  }
}
