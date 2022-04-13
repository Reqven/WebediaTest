//
//  MasterViewController.swift
//  WebediaTest

import UIKit

class MasterViewController: UITableViewController {
  
  //MARK: - Properties
  @IBOutlet weak var sortingControl: UISegmentedControl!
  
  //MARK: DataSource
  var forecast = Forecast()
  var upcoming: Forecast {
    forecast.sorted { $0.day < $1.day }
  }
  var hottest: Forecast {
    forecast
      .filter { $0.chanceRain < 0.5 }
      .sorted { $0.high > $1.high }
  }
  
  //MARK: DataSourceType
  private var dataSourceIndex: Int {
    sortingControl.selectedSegmentIndex
  }
  private var dataSourceType: ForecastType? {
    ForecastType(rawValue: dataSourceIndex)
  }
  private var dataSource: Forecast {
    guard let type = dataSourceType else { return [] }
    switch(type) {
      case .upcoming: return upcoming
      case .hottest: return hottest
    }
  }
  
  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    loadForecast()
    
    sortingControl.addTarget(self, action: #selector(self.onSort), for: .valueChanged)
  }
  
  private func loadForecast() {
    let stringURL = "https://xmfw.github.io/forecast.json"
    guard let forecastURL = URL(string: stringURL) else { return }
    
    Network.json(from: forecastURL, as: Forecast.self) { result in
      switch(result) {
        case .failure(let error): print(error)
        case .success(let data): DispatchQueue.main.async {
          self.forecast = data
          self.tableView.reloadData()
        }
      }
    }
  }
  
  @objc func onSort(_ segmentedControl: UISegmentedControl) {
    tableView.reloadData()
  }
}


//MARK: - UITableViewController
extension MasterViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard let splitViewController = splitViewController as? SplitViewController,
          let rootNavigationController = splitViewController.detailRootController,
          let detailViewController = rootNavigationController.topViewController as? DetailViewController
    else { return }
    
    detailViewController.day = dataSource[indexPath.row]
    splitViewController.showDetailViewController(rootNavigationController, sender: self)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let forecast = dataSource[indexPath.row]
    
    cell.textLabel?.text = "Day \(forecast.day): \(forecast.description)"
    //TODO: Set textLabel color to gray if image has been downloaded
    
    return cell
  }
}


//MARK: - ImageDownloadDelegate
extension MasterViewController: ImageDownloadDelegate {
  
  func imageDownloaded(for forecast: Day) {
    //TODO: Update models and reloadData
  }
}
