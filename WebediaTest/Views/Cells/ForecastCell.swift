//
//  ForecastCell.swift
//  WebediaTest
//
//  Created by Manu on 13/04/2022.
//

import UIKit

class ForecastCell: UITableViewCell {
  
  //MARK: - Properties
  static let reusableIdentifier = "ForecastCell"
  private var indicatorImageView: UIImageView? {
    accessoryView as? UIImageView
  }
  private var viewModel: ForecastCellViewModel? {
    didSet { updateView() }
  }

  //MARK: - Methods
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    accessoryView = UIImageView()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    indicatorImageView?.image = nil
  }
  
  func configure(with viewModel: ForecastCellViewModel) {
    self.viewModel = viewModel
  }
  
  private func updateView() {
    guard let viewModel = viewModel else { return }
    textLabel?.text = viewModel.title
    
    guard viewModel.imageDownloaded else { return }
    let image = UIImage(compatibleSystemName: "photo")
    indicatorImageView?.image = image?.withRenderingMode(.alwaysTemplate)
    indicatorImageView?.sizeToFit()
  }
}
