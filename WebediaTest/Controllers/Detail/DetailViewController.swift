//
//  DetailViewController.swift
//  WebediaTest

import UIKit

protocol ForecastUpdateDelegate {
  func didUpdateForecast()
}

class DetailViewController: UITableViewController {
  
  //MARK: - Properties
  @IBOutlet weak var downloadButton: UIButton!
  var delegate: ForecastUpdateDelegate?
  var viewModel: DetailViewControllerViewModel? {
    didSet { updateView() }
  }
  
  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    let nib = UINib(nibName: ImageCell.reusableIdentifier, bundle: .main)
    tableView.register(nib, forCellReuseIdentifier: ImageCell.reusableIdentifier)
    
    if #unavailable(iOS 14) {
      navigationItem.leftItemsSupplementBackButton = true
      navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    }
  }
  
  private func updateView() {
    guard let viewModel = viewModel else { return }
    viewModel.delegate = self

    title = viewModel.title
    tableView.dataSource = viewModel
    tableView.reloadData()
    
    downloadButton.isHidden = viewModel.imageDownloaded
  }
  
  @IBAction func onDownload(_ sender: UIButton) {
    viewModel?.downloadImage()
  }
}


//MARK: - ImageDownloadDelegate
extension DetailViewController: ImageDownloadDelegate {
  
  func didDownloadImage() {
    downloadButton.isHidden = true
    delegate?.didUpdateForecast()
    tableView.reloadData()
  }
}
