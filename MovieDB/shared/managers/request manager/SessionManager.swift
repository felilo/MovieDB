//
//  SessionManager.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation
import Alamofire

class SessionManager {
  
  static let shared: Session = SessionManager().session
  
  /**
   asdas
   */
  private let sessionConfig: URLSessionConfiguration = {
    let item = URLSessionConfiguration.af.default
    item.requestCachePolicy = .returnCacheDataElseLoad
//    item.timeoutIntervalForRequest = 10.0
    return item
  }()
  
  
  private let responseCacher = ResponseCacher(behavior: .modify { _, response in
    let userInfo = ["date": Date()]
    return CachedURLResponse(
      response: response.response,
      data: response.data,
      userInfo: userInfo,
      storagePolicy: .allowed)
  })
  
  
  private let session: Session
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  

  private init() {
    session = .init(
      configuration: sessionConfig,
      interceptor: CustomRequestInterceptor(),
      cachedResponseHandler: responseCacher,
      eventMonitors: []
    )
  }
}



fileprivate extension SessionManager {
  
  
  struct CustomRequestInterceptor: RequestInterceptor {
    
    
    // ---------------------------------------------------------------------
    // MARK: RequestInterceptor
    // ---------------------------------------------------------------------
    
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
      var urlRequest = urlRequest
      
      if let token = RequestManager.handleGetToken?() {
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      }
      
      completion(.success(urlRequest))
    }
  }
}

