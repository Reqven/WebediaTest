//
//  DetailViewController.swift
//  WebediaTest

import UIKit

protocol ForecastUpdateDelegate {
  func didUpdateForecast()
}

class DetailViewController: UIViewController {
  
  //MARK: - Properties
  @IBOutlet weak var forecastLabel: UILabel!
  @IBOutlet weak var sunriseLabel: UILabel!
  @IBOutlet weak var sunsetLabel: UILabel!
  @IBOutlet weak var highLabel: UILabel!
  @IBOutlet weak var lowLabel: UILabel!
  @IBOutlet weak var chanceOfRainLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var downloadButton: UIButton!
  
  var delegate: ForecastUpdateDelegate?
  var viewModel: DetailViewControllerViewModel? {
    didSet {
      viewModel?.delegate = self
      updateView()
    }
  }
  
  
  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  @IBAction func downloadImage(_ sender: Any) {
    guard let viewModel = viewModel else { return }
    viewModel.downloadImage()
  }
}


//MARK: - Setup
extension DetailViewController {
  
  private func setup() {
    if #unavailable(iOS 14) {
      navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
      navigationItem.leftItemsSupplementBackButton = true
    }
  }
  
  private func updateView() {
    guard let viewModel = viewModel else { return }
    loadViewIfNeeded()

    title = viewModel.title
    forecastLabel.text = viewModel.description
    sunriseLabel.text = viewModel.sunrise
    sunsetLabel.text = viewModel.sunset
    highLabel.text = viewModel.high
    lowLabel.text = viewModel.low
    chanceOfRainLabel.text = viewModel.rain
    imageView.image = viewModel.image
    
    downloadButton.isHidden = viewModel.image != nil
  }
}


//MARK: - ImageDownloadDelegate
extension DetailViewController: ImageDownloadDelegate {
  
  func didDownloadImage() {
    delegate?.didUpdateForecast()
    updateView()
  }
}
