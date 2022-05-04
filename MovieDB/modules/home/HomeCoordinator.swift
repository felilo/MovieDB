//
//  HomeCoordinator.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import UIKit

class HomeCoordinator: Coordinator {
  
  
  // ---------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------
  
  
  var parent: Coordinator!
  var navigationController: UINavigationController = .init()
  var childCoordinators = [Coordinator]()
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(present parent: Coordinator, animated: Bool = true) {
    self.parent = parent
    root.modalPresentationStyle = .fullScreen
    root.setNavigationBarHidden(false, animated: false)
    root.navigationBar.prefersLargeTitles = true
    self.parent.present(root, animated: animated)
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  func start(animated: Bool = false) {
    let provider = MovieProvider()
    let vm = MediaListViewModel(coordinator: self, provider: provider)
    let ctrl = MediaListController(viewModel: vm)
    root.viewControllers = [ctrl]
  }
  
  
  func showDetail(item: EntertainmentMediaItem)  {
    let provider = VideoProvider()
    let vm = EntertainmentMediaDetailViewModel(
      coordinator: self,
      provider: provider,
      item: item
    )
    let ctrl = EntertainmentMediaDetailController(viewModel: vm)
    ctrl.modalPresentationStyle = .fullScreen
    push(ctrl)
  }
  
  
  func showVideo(item: VideoModel) {
    let vm = VideoPlayerViewModel(coordinator: self, item: item)
    let ctrl = VideoPlayerController(viewModel: vm)
    present(ctrl, animated: true)
  }
  
  
  func showAlert(title: String?, message: String?) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    root.viewControllers.last?.present(alert, animated: true)
  }
}
