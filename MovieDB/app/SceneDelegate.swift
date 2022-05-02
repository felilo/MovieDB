//
//  SceneDelegate.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import UIKit


@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    setupCoordinator(scene: scene)
  }
  
  
  func setupCoordinator(scene: UIScene) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
          let windowScene = (scene as? UIWindowScene)
    else { return }
    window = .init(windowScene: windowScene)
    window?.rootViewController = appDelegate.mainCoordinator?.root
    window?.makeKeyAndVisible()
    appDelegate.mainCoordinator?.start(animated: false)
  }
  
}

