//
//  UIImage+Ext.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import UIKit

extension UIImage {
  
  convenience init?(compatibleSystemName name: String) {
    if #available(iOS 13.0, *) {
      self.init(systemName: name)
    } else {
      self.init(named: name)
    }
  }
}
