//
//  Network.swift
//  WebediaTest
//
//  Created by Manu on 12/04/2022.
//

import UIKit

class Network {
  
  static func json<T: Codable>(from url: URL, as _: T.Type, _ completion: @escaping (Result<T, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data {
          do {
            let response = try JSONDecoder().decode(T.self, from: data)
            completion(.success(response))
          } catch let error {
            completion(.failure(error))
          }
      }
    }.resume()
  }
  
  static func image(from url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data, let image = UIImage(data: data) {
        completion(.success(image))
      }
    }.resume()
  }
}
