//
//  MovieApiService.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation

class MovieApiService: MovieProviderProtocol {
  
  
  // ---------------------------------------------------------------------
  // MARK: MovieProviderProtocol
  // ---------------------------------------------------------------------
  
  
  func list<T>(category: EntertainmentMediaCategory, handleSuccess: @escaping HandleSuccess<T>){
    
    EntertainmentEndPoint.list(category: category, type: .movie)
      .getEndPoint()
      .requestCodableData { (response: Result<HandleListResult<T>, Error>) in
        switch response {
          case .success(let result):
            handleSuccess(.success(result.items))
            break
          case .failure(let error):
            handleSuccess(.failure(error))
            break
        }
      }
  }
  
  
  func detail<T>(id: Int, handleSuccess: @escaping HandleSuccess<T>){
    EntertainmentEndPoint.detail(type: .movie, id: id)
      .getEndPoint()
      .requestCodableData(completion: handleSuccess)
  }
}


extension MovieApiService {
  
  
  // ---------------------------------------------------------------------
  // MARK: Enums
  // ---------------------------------------------------------------------
  

  enum EntertainmentEndPoint {
    
    case list(category: EntertainmentMediaCategory, type: EntertainmentMediaType)
    case detail(type: EntertainmentMediaType, id: Int)
    case videos(type: EntertainmentMediaType, id: Int)
    
    func getEndPoint() -> RequestManager {
      switch self {
        case .list(let category, let type):
          return .init(path: type.rawValue, category.rawValue)
        case .detail(let type, let id):
          return .init(path: type.rawValue, "\(id)")
        case .videos(let type, let id):
          return .init(path: type.rawValue, "\(id)", "videos")
      }
    }
  }
}


