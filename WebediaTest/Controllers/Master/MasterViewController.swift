//
//  MasterViewController.swift
//  WebediaTest

import UIKit

class MasterViewController: UITableViewController {
  
  //MARK: - Properties
  @IBOutlet weak var sortingControl: UISegmentedControl!
  private var viewModel = MasterViewControllerViewModel()

  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    viewModel.delegate = self
    viewModel.loadData()
    
    tableView.delegate = viewModel
    tableView.dataSource = viewModel
    
    tableView.tableFooterView = UIView()
    let nib = UINib(nibName: ForecastCell.reusableIdentifier, bundle: .main)
    tableView.register(nib, forCellReuseIdentifier: ForecastCell.reusableIdentifier)
    
    sortingControl.addTarget(self, action: #selector(self.onSort), for: .valueChanged)
  }
  
  @objc func onSort(_ segmentedControl: UISegmentedControl) {
    let index = segmentedControl.selectedSegmentIndex
    guard let type = ForecastListType(rawValue: index) else { return }
    
    viewModel.sortData(with: type)
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
    
    detailViewController.delegate = self
    detailViewController.viewModel = DetailViewControllerViewModel(forecast: forecast)
    splitViewController.showDetailViewController(rootNavigationController, sender: self)
  }
}


//MARK: - ForecastUpdateDelegate
extension MasterViewController: ForecastUpdateDelegate {
  
  func didUpdateForecast() {
    tableView.reloadData()
  }
}
