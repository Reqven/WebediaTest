//
//  MasterViewController.swift
//  WebediaTest

import UIKit

class MasterViewController: UITableViewController {
  
  //MARK: - Properties
  @IBOutlet weak var sortingControl: UISegmentedControl!
  var detailViewController: DetailViewController? = nil
  
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
    
    if let split = splitViewController {
      let controllers = split.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
    
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
  
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let day = dataSource[indexPath.row]
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.delegate = self
        controller.day = day
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
        controller.title = "Day \(day.day)"
      }
    }
  }
}


//MARK: - UITableViewController
extension MasterViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
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
