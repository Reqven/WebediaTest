//
//  Forecast.swift
//  WebediaTest
//
//  Created by Manu on 12/04/2022.
//

import UIKit

class Forecast: Codable {
  let day: String
  let description: String
  let sunrise: Int
  let sunset: Int
  let chanceRain: Double
  let high: Int
  let low: Int
  let imageUrl: String
  var image: UIImage?
  
  enum CodingKeys: String, CodingKey {
    case day
    case description
    case sunrise
    case sunset
    case chanceRain = "chance_rain"
    case high
    case low
    case imageUrl = "image"
  }
}

typealias ForecastList = [Forecast]


extension ForecastList {
  
  func upcoming() -> Self {
    let result: ComparisonResult = .orderedAscending
    return self.sorted { $0.day.localizedStandardCompare($1.day) == result }
  }
  
  func hottest() -> Self {
    return self
      .filter { $0.chanceRain < 0.5 }
      .sorted { $0.high > $1.high }
  }
}
