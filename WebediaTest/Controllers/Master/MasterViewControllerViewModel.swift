//
//  MasterViewControllerViewModel.swift
//  WebediaTest
//
//  Created by Manu on 13/04/2022.
//

import UIKit

protocol ForecastListDelegate {
  func didLoad()
  func didSelect(forecast: Forecast)
}

class MasterViewControllerViewModel: NSObject {
  
  //MARK: - Properties
  var delegate: ForecastListDelegate?
  
  private var forecast = ForecastList()
  private var upcoming: ForecastList { forecast.upcoming() }
  private var hottest: ForecastList { forecast.hottest() }
  
  private var dataSourceType: ForecastListType = .upcoming
  private var dataSource: ForecastList {
    switch(dataSourceType) {
      case .upcoming: return upcoming
      case .hottest: return hottest
    }
  }
  
  
  //MARK: - Methods
  func loadData() {
    let stringURL = "https://xmfw.github.io/forecast.json"
    guard let forecastURL = URL(string: stringURL) else { return }
    
    Network.json(from: forecastURL, as: ForecastList.self) { result in
      switch(result) {
      case .failure(let error): print(error)
        case .success(let data): DispatchQueue.main.async {
          self.forecast = data
          self.delegate?.didLoad()
        }
      }
    }
  }
  
  func sortData(with type: ForecastListType) {
    dataSourceType = type
  }
}


//MARK: TableView
extension MasterViewControllerViewModel: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    delegate?.didSelect(forecast: dataSource[indexPath.row])
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reusableIdentifier, for: indexPath) as! ForecastCell
    cell.configure(with: ForecastCellViewModel(forecast: dataSource[indexPath.row]))
    return cell
  }
}
