//
//  MovieApiService.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation

class VideoApiService: VideoProviderProtocol {
  
  
  // ---------------------------------------------------------------------
  // MARK: MovieProviderProtocol
  // ---------------------------------------------------------------------
  
  
  func list<T>(mediaId: Int, type: EntertainmentMediaType,  handleSuccess: @escaping HandleSuccess<T>){
    
    VideoEndPoint.list(type: type, id: mediaId)
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
}



extension VideoApiService {

  
  // ---------------------------------------------------------------------
  // MARK: Enums
  // ---------------------------------------------------------------------
  
  
  enum VideoEndPoint {
    
    case list(type: EntertainmentMediaType, id: Int)
    
    func getEndPoint() -> RequestManager {
      switch self {
        case .list(let type, let id):
          return .init(path: type.rawValue, "\(id)", "videos")
      }
    }
  }
}
