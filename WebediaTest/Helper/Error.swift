//
//  Error.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import Foundation

//MARK: - CustomError
enum CError: String, LocalizedError {
  case invalidResponse = "The server returned an invalid response"
  case invalidImage = "Unable to create an image from the response data"
  case invalidData = "Unable to process the response data"
  case unknown = "An unknown error occured"
  
  public var errorDescription: String? {
    return self.rawValue
  }
}
