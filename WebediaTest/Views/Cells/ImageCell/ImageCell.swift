//
//  ImageCell.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import UIKit

class ImageCell: UITableViewCell {
  
  //MARK: - Properties
  static let reusableIdentifier = "ImageCell"
  @IBOutlet weak var forecastImageView: UIImageView!
  
  private var viewModel: ImageCellViewModel? {
    didSet { updateView() }
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    forecastImageView.image = nil
  }
  
  func configure(with viewModel: ImageCellViewModel) {
    self.viewModel = viewModel
  }
  
  private func updateView() {
    forecastImageView.image = viewModel?.image
  }
}
