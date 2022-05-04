//
//  MainCoordinator.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//


import UIKit

class MainCoordinator: Coordinator {
  
  
  // ---------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------
  
  
  var parent: Coordinator!
  var navigationController: UINavigationController = .init()
  var childCoordinators = [Coordinator]()
  
  
  // ---------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------
  
  
  init() {
    let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
    navigationController.viewControllers = [vc]
    navigationController.setNavigationBarHidden(true, animated: false)
  }
  
  
  // ---------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------
  
  
  func start(animated: Bool = false) {
    let coordinator = HomeCoordinator(present: self, animated: false)
    childCoordinators += [coordinator]
    coordinator.start(animated: false)
  }
}
