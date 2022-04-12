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
  var day: Day?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  func configureView() {
    guard let day = day else { return }

    forecastLabel.text = day.description
    sunriseLabel.text = "\(day.sunrise) seconds"
    sunsetLabel.text = "\(day.sunset) seconds"
    highLabel.text = "\(day.high)ºC"
    lowLabel.text = "\(day.low)ºC"
    chanceOfRainLabel.text = "\(day.chanceRain)%"
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
