//
//  ForecastCell.swift
//  WebediaTest
//
//  Created by Manu on 13/04/2022.
//

import UIKit

class ForecastCell: UITableViewCell {
  
  static let reusableIdentifier = "ForecastCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(with forecast: Forecast) {
    textLabel?.text = "Day \(forecast.day): \(forecast.description)"
    //TODO: Set textLabel color to gray if image has been downloaded
  }
}
