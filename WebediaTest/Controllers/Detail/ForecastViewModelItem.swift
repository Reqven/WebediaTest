//
//  Dev.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import UIKit

enum ForecastViewModelItemType {
  case attribute
  case image
}

protocol ForecastViewModelItem {
  var type: ForecastViewModelItemType { get }
  var sectionTitle: String { get }
  var rowCount: Int { get }
}

extension ForecastViewModelItem {
  var rowCount: Int { return 1 }
}


//MARK: - ForecastViewModelAttributesItem
class ForecastViewModelAttributesItem: ForecastViewModelItem {
  
  var type: ForecastViewModelItemType { .attribute }
  var sectionTitle: String { "Data" }
  var rowCount: Int { attributes.count }
  
  var attributes: [Attribute]
  
  init(forecast: Forecast) {
    self.attributes = [
      Attribute(name: "Forecast", value: forecast.description),
      Attribute(name: "Sunrise", value: "\(forecast.sunrise) seconds"),
      Attribute(name: "Sunset", value: "\(forecast.sunset) seconds"),
      Attribute(name: "High", value: "\(forecast.high)ºC"),
      Attribute(name: "Low", value: "\(forecast.low)ºC"),
      Attribute(name: "Chance of rain", value: "\(Int(forecast.chanceRain * 100))%")
    ]
  }
  
  func attribute(for indexPath: IndexPath) -> Attribute {
    return attributes[indexPath.row]
  }
}


//MARK: - ForecastViewModelImageItem
class ForecastViewModelImageItem: ForecastViewModelItem {
  
  var type: ForecastViewModelItemType { return .image }
  var sectionTitle: String { return "Image" }
  
  var image: UIImage?
  
  init(forecast: Forecast) {
    self.image = forecast.image
  }
}
