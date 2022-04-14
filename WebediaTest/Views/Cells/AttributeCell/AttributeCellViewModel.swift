//
//  DetailCellViewModel.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import Foundation

class AttributeCellViewModel {
  
  private var attribute: Attribute
  var name: String { attribute.name }
  var value: String? { attribute.value }
  
  init(attribute: Attribute) {
    self.attribute = attribute
  }
}
