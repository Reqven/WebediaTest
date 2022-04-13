//
//  Forecast.swift
//  WebediaTest
//
//  Created by Manu on 12/04/2022.
//

import Foundation

typealias ForecastList = [Forecast]

struct Forecast: Codable {
  let day: String
  var description: String
  let sunrise: Int
  let sunset: Int
  let chanceRain: Double
  let high: Int
  let low: Int
  let image: String
  
  enum CodingKeys: String, CodingKey {
    case day
    case description
    case sunrise
    case sunset
    case chanceRain = "chance_rain"
    case high
    case low
    case image
  }
}
