//
//  UIViewController+Ext.swift
//  WebediaTest
//
//  Created by Manu on 14/04/2022.
//

import UIKit

extension UIViewController {
  
  func presentAlert(title: String?, message: String?) {
    DispatchQueue.main.async {
      let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
      controller.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(controller, animated: true)
    }
  }
}
