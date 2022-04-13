//
//  DetailViewControllerViewModel.swift
//  WebediaTest
//
//  Created by Manu on 13/04/2022.
//

import UIKit

class DetailViewControllerViewModel {
  
  //MARK: - Properties
  private var forecast: Forecast
  var delegate: ImageDownloadDelegate?
  
  public private(set) var image: UIImage?
  var title: String { "Day \(forecast.day)" }
  var description: String { forecast.description }
  
  var low: String { "\(forecast.low)ºC" }
  var high: String { "\(forecast.high)ºC" }
  var rain: String { "\(forecast.chanceRain)%" }
  var sunset: String { "\(forecast.sunset) seconds" }
  var sunrise: String { "\(forecast.sunrise) seconds" }
  
  
  //MARK: - Methods
  init(forecast: Forecast) {
    self.forecast = forecast
  }
  
  func downloadImage() {
    guard let imageUrl = URL(string: forecast.image) else { return }
    Network.image(from: imageUrl) { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
        case .failure(let error): print(error)
        case .success(let image): DispatchQueue.main.async {
          self.image = image
          self.delegate?.didDownloadImage()
        }
      }
    }
  }
}
