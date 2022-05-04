//
//  VideoPlayerViewModel.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import Foundation


class VideoPlayerViewModel {
  
  
  typealias ModelItem = VideoModel
  
  
  // ---------------------------------------------------------------------
  // MARK: Constants
  // ---------------------------------------------------------------------
  
  
  let item: ModelItem
  let coordinator: HomeCoordinator
  let onPlayer = Bindable<Bool>()
  let onError = Bindable<String>()
  
  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------
  
  
  var playerVideo: PlayerVideo?
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(coordinator: HomeCoordinator, item: ModelItem){
    self.item = item
    self.coordinator = coordinator
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  

  
  func close() {
    coordinator.dismiss()
  }
  
  
  func setupPlayer() {
    guard let id = item.key, item.site == .youtube else {
      onError.value = "This video is not support yet"
      return
    }
    playerVideo = YoutubePlayerView(id: id)
    onPlayer.value = true
  }
  
  
  func startPlayer() {
    playerVideo?.start()
  }
}
