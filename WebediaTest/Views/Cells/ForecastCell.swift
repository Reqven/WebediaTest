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

  //MARK: - Methods
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    accessoryView = UIImageView()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    indicatorImageView?.image = nil
  }
  
  func configure(with forecast: Forecast) {
    textLabel?.text = "Day \(forecast.day): \(forecast.description)"
    
    guard let _ = forecast.image else { return }
    let image = UIImage(compatibleSystemName: "photo")
    indicatorImageView?.image = image?.withRenderingMode(.alwaysTemplate)
    indicatorImageView?.sizeToFit()
  }
}
