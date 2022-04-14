//
//  ForecastCell.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import UIKit

class ForecastCell: UITableViewCell {

  //MARK: - Properties
  static let reusableIdentifier = "ForecastCell"
  @IBOutlet weak var forecastLabel: UILabel!
  @IBOutlet weak var downloadedImageView: UIImageView!
  
  private var viewModel: ForecastCellViewModel? {
    didSet { updateView() }
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    downloadedImageView.image = nil
  }
  
  func configure(with viewModel: ForecastCellViewModel) {
    self.viewModel = viewModel
  }
  
  private func updateView() {
    guard let viewModel = viewModel else { return }
    forecastLabel.text = viewModel.label
    
    guard viewModel.imageDownloaded else { return }
    let image = UIImage(compatibleSystemName: "photo")
    downloadedImageView.image = image?.withRenderingMode(.alwaysTemplate)
    downloadedImageView.sizeToFit()
  }
}
