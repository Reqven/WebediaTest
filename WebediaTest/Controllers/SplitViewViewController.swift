//
//  SplitViewViewController.swift
//  WebediaTest
//
//  Created by Manu on 13/04/2022.
//

import UIKit

class SplitViewController: UISplitViewController {
  
  private var primaryRootController: UINavigationController?
  private var secondaryRootController: UINavigationController?
  
  var masterRootController: UINavigationController? {
    guard #available(iOS 14.0, *) else { return primaryRootController }
    return viewController(for: .primary) as? UINavigationController
  }
  
  var detailRootController: UINavigationController? {
    guard #available(iOS 14.0, *) else { return secondaryRootController }
    return viewController(for: .secondary) as? UINavigationController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    
    primaryRootController = viewControllers.first as? UINavigationController
    secondaryRootController = viewControllers.last as? UINavigationController
  }
}


//MARK: - UISplitViewControllerDelegate
extension SplitViewController: UISplitViewControllerDelegate {
  
  //MARK: - Classic SplitView
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    // On iPhone, display Master first by collapsing immediately
    return true
  }
  
  //MARK: - Column-Styles SplitView
  @available(iOS 14.0, *)
  func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
    // On iPhone, display Master first by collapsing immediately
    return .primary
  }
}

