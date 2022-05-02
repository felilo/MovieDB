//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  var window: UIWindow?
  var mainCoordinator: MainCoordinator?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ConfigApp.Api()
    setupCoordinator()
    return true
  }
  
  
  // MARK: UISceneSession Lifecycle
  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  
  func setupCoordinator() {
    mainCoordinator = MainCoordinator()
    if #unavailable(iOS 13 ) {
      window = UIWindow()
      window?.rootViewController = mainCoordinator?.root
      window?.makeKeyAndVisible()
      mainCoordinator?.start(animated: false)
    }
  }
}

