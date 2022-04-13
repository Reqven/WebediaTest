//
//  DetailViewController.swift
//  WebediaTest

import UIKit

protocol ImageDownloadDelegate {
  func imageDownloaded(for day: Day)
}

class DetailViewController: UIViewController {
  
  @IBOutlet weak var forecastLabel: UILabel!
  @IBOutlet weak var sunriseLabel: UILabel!
  @IBOutlet weak var sunsetLabel: UILabel!
  @IBOutlet weak var highLabel: UILabel!
  @IBOutlet weak var lowLabel: UILabel!
  @IBOutlet weak var chanceOfRainLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var delegate: ImageDownloadDelegate?
  var day: Day? {
    didSet {
      updateView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  @IBAction func downloadImage(_ sender: Any) {
    guard let forecast = day else { return }
    
    if let forecastUrl = URL(string: forecast.image) {
      let imageDownloadSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
      imageDownloadSession.dataTask(with: forecastUrl, completionHandler: { (data, response, error) in
        self.imageView.image = UIImage(data: data!)
        self.delegate!.imageDownloaded(for: forecast)
      }).resume()
    }
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
    guard let day = day else { return }
    loadViewIfNeeded()

    title = "Day \(day.day)"
    forecastLabel.text = day.description
    sunriseLabel.text = "\(day.sunrise) seconds"
    sunsetLabel.text = "\(day.sunset) seconds"
    highLabel.text = "\(day.high)ºC"
    lowLabel.text = "\(day.low)ºC"
    chanceOfRainLabel.text = "\(day.chanceRain)%"
  }
}
