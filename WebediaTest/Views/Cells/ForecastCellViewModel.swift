//
//  ForecastCellViewModel.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import Foundation

class ForecastCellViewModel {
  
  //MARK: - Properties
  private var forecast: Forecast
  var imageDownloaded: Bool { forecast.image != nil }
  var title: String { "Day \(forecast.day): \(forecast.description)" }
  
  //MARK: - Methods
  init(forecast: Forecast) {
    self.forecast = forecast
  }
}
