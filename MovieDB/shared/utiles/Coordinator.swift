//
//  Coordinator.swift
//  MovieDB
//
//  Created by Andres Lozano on 29/04/22.
//

import UIKit


public protocol Coordinator {
  
  
  // ---------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------
  
  
  var parent:Coordinator! { get set }
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  
  
  // ---------------------------------------------------------
  // MARK: Funcs
  // ---------------------------------------------------------
  
  
  func start(animated: Bool) -> Void
}



extension Coordinator {
  
  
  // ---------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------
  
  
  public var root: UINavigationController {
    return navigationController
  }
  
  
  public func push(_ viewController: UIViewController, animated: Bool = true) {
    root.pushViewController(viewController, animated: animated)
  }
  
  
  public func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
    root.present(viewController, animated: animated, completion: completion)
  }
  
  
  public func pop(animated: Bool = true) {
    root.popViewController(animated: animated)
  }
  
  
  public func popToRoot(animated: Bool = true) {
    root.popToRootViewController(animated: animated)
  }
  
  
  public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
    root.dismiss(animated: animated, completion: completion)
  }
}
