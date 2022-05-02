//
//  MediaDetailViewModel.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation

class EntertainmentMediaDetailViewModel: NSObject {
  
  
  typealias ModelItem = EntertainmentMediaItem
  
  
  // ---------------------------------------------------------------------
  // MARK: Constants
  // ---------------------------------------------------------------------
  
  
  let coordinator: HomeCoordinator
  let provider: VideoProvider
  
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  var item = Bindable<ModelItem>()
  var onFetchVideos = Bindable<Bool>()
  var onError = Bindable<String>()
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(coordinator: HomeCoordinator, provider: VideoProvider, item: ModelItem){
    self.coordinator = coordinator
    self.provider = provider
    super.init()
    self.item.value = item
  }
  
  
  func close() {
    coordinator.pop()
  }
  
  
  func fetchVideos() {
    guard let item = getEntertainmentMediaType()
    else { return }
    
    provider.getList(mediaId: item.id, type: item.type) { [weak self] response in
      switch response {
        case .success(let result):
          try? self?.handleSuccess(items: result)
        case .failure(let error):
          self?.onError.value = error.localizedDescription
      }
    }
  }
  
  
  private func handleSuccess(items: [VideoModel]) throws {
    guard let item = item.value else { return }
    item.updateVideos(items)
    onFetchVideos.value = true
  }
  
  
  private func getEntertainmentMediaType() -> (id: Int, type: EntertainmentMediaType)?{
    guard let item = item.value,
          let id = item.getId()
    else { return nil }
    return (id, item.getMediaType())
  }
  
  
  func playVideo() {
    guard let video = item.value?.getVideos().first
    else { return  }
    coordinator.showVideo(item: video)
  }
}
