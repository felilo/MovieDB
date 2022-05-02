//
//  MovieProvider.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation


class VideoProvider {
  
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  var dataSource: VideoProviderProtocol
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  
  init(dataSource: DataSource = .api) {
    self.dataSource = dataSource.source
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  func getList(mediaId: Int, type: EntertainmentMediaType, handleSuccess: @escaping HandleSuccess<[VideoModel]>) {
    dataSource.list(mediaId: mediaId, type: type, handleSuccess: handleSuccess)
  }
}



extension VideoProvider {
  
  enum DataSource {
    case api, custom(service: VideoProviderProtocol)
    
    // ---------------------------------------------------------------------
    // MARK: Attributes
    // ---------------------------------------------------------------------

    
    var source: VideoProviderProtocol {
      switch self {
        case .api:
          return VideoApiService()
        case .custom(let service):
          return service
      }
    }
  }
}
