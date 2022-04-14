//
//  DetailViewControllerViewModel.swift
//  WebediaTest
//
//  Created by Manu on 13/04/2022.
//

import UIKit

protocol ImageDownloadDelegate {
  func didDownloadImage()
}

class DetailViewControllerViewModel: NSObject {
  
  //MARK: - Properties
  private var forecast: Forecast
  private var dataSource: [ForecastViewModelItem] {
    guard let _ = forecast.image else { return [attributesSection] }
    return [attributesSection, imageSection]
  }
  
  private var attributesSection: ForecastViewModelAttributesItem {
    ForecastViewModelAttributesItem(forecast: forecast)
  }
  private var imageSection: ForecastViewModelImageItem {
    ForecastViewModelImageItem(forecast: forecast)
  }
  
  var delegate: ImageDownloadDelegate?
  var title: String { "Day \(forecast.day)" }
  var imageDownloaded: Bool { forecast.image != nil }
  
  
  //MARK: - Methods
  init(forecast: Forecast) {
    self.forecast = forecast
  }
  
  func downloadImage() {
    guard let imageUrl = URL(string: forecast.imageUrl) else { return }
    Network.image(from: imageUrl) { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
        case .failure(let error): print(error)
        case .success(let image): DispatchQueue.main.async {
          self.forecast.image = image
          self.delegate?.didDownloadImage()
        }
      }
    }
  }
}


//MARK: - TableView
extension DetailViewControllerViewModel: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource[section].rowCount
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dataSource[section].sectionTitle
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewModelItem = dataSource[indexPath.section]
    
    switch(viewModelItem.type) {
      case .attribute:
        if let item = viewModelItem as? ForecastViewModelAttributesItem {
          let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.reusableIdentifier, for: indexPath) as! AttributeCell
          cell.configure(with: AttributeCellViewModel(attribute: item.attribute(for: indexPath)))
          return cell
        }
      case .image:
        if let item = viewModelItem as? ForecastViewModelImageItem {
          let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reusableIdentifier, for: indexPath) as! ImageCell
          cell.configure(with: ImageCellViewModel(image: item.image))
          return cell
        }
      }
    return UITableViewCell()
  }
}
