//
//  MasterViewController.swift
//  WebediaTest

import UIKit

protocol MasterViewControllerDelegate {
  func didSort(with type: ForecastListType)
}

class MasterViewController: UITableViewController {
  
  //MARK: - Properties
  @IBOutlet weak var sortingControl: UISegmentedControl!
  private var viewModel = MasterViewControllerViewModel()
  private var delegate: MasterViewControllerDelegate?
  

  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    viewModel.delegate = self
    viewModel.loadForecast()
    
    delegate = viewModel
    tableView.delegate = viewModel
    tableView.dataSource = viewModel
    
    sortingControl.addTarget(self, action: #selector(self.onSort), for: .valueChanged)
  }
  
  @objc func onSort(_ segmentedControl: UISegmentedControl) {
    let index = segmentedControl.selectedSegmentIndex
    guard let type = ForecastListType(rawValue: index) else { return }
    
    delegate?.didSort(with: type)
    tableView.reloadData()
  }
}


//MARK: - ForecastListDelegate
extension MasterViewController: ForecastListDelegate {
  
  func didLoad() {
    tableView.reloadData()
  }
  
  func didSelect(forecast: Forecast) {
    guard let splitViewController = splitViewController as? SplitViewController else { return }
    guard let rootNavigationController = splitViewController.detailRootController else { return }
    guard let detailViewController = rootNavigationController.topViewController as? DetailViewController else { return }
    
    detailViewController.viewModel = DetailViewControllerViewModel(forecast: forecast)
    splitViewController.showDetailViewController(rootNavigationController, sender: self)
  }
}
