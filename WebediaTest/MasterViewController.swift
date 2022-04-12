//
//  MasterViewController.swift
//  WebediaTest

import UIKit

class MasterViewController: UITableViewController, ImageDownloadDelegate {
  
  @IBOutlet weak var sortingControl: UISegmentedControl!
  
  var detailViewController: DetailViewController? = nil
  var forecast = Forecast()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let split = splitViewController {
      let controllers = split.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
    
    sortingControl.addTarget(self, action: #selector(self.sortingControlAction), for: .valueChanged)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if let forecastUrl = URL(string: "https://xmfw.github.io/forecast.json") {
      URLSession.shared.dataTask(with: forecastUrl, completionHandler: { (data, response, error) in
        self.forecast = try! JSONDecoder().decode(Forecast.self, from: data!)
        self.tableView.reloadData()
      }).resume()
    }
  }
  
  func imageDownloaded(for forecast: Day) {
    //TODO: Update models and reloadData
  }
  
  @objc func sortingControlAction(_ segmentedControl: UISegmentedControl) {
    //TODO: Sort days and reloadData
  }
  
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let forecast = forecast[indexPath.row]
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.delegate = self
        controller.day = forecast
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
        controller.title = "Day \(forecast.day)"
      }
    }
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecast.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let forecast = forecast[indexPath.row]
    
    cell.textLabel?.text = "Day \(forecast.day): \(forecast.description)"
    //TODO: Set textLabel color to gray if image has been downloaded
    
    return cell
  }
}
