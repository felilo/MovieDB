//
//  MovieProvider.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation

class MovieProvider {
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  var dataSource: MovieProviderProtocol
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  
  init(dataSource: DataSource = .api) {
    self.dataSource = dataSource.source
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  func getItems(category: EntertainmentMediaCategory, handleSuccess: @escaping HandleSuccess<[MovieModel]>) {
    dataSource.list(category: category, handleSuccess: handleSuccess)
  }
  
  
  func getDetail(id: Int, handleSuccess: @escaping (Result<MovieModel, Error>) -> Void) {
    dataSource.detail(id: id, handleSuccess: handleSuccess)
  }
}


extension MovieProvider {
  
  enum DataSource {
    case api, custom(service: MovieProviderProtocol)
    
    // ---------------------------------------------------------------------
    // MARK: Attributes
    // ---------------------------------------------------------------------

    
    var source: MovieProviderProtocol {
      switch self {
        case .api:
          return MovieApiService()
        case .custom(let service):
          return service
      }
    }
  }
}
