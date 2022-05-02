//
//  RequestManager.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation
import Alamofire

class RequestManager {
  
  
  private static let base_url: URL? = .init(string: ConfigApp.shared.baseURL)
  static var handleGetToken: (() -> String?)? = nil
  static var isAvailableNetwork:Bool {
    return NetworkReachabilityManager()?.isReachable == true
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------
  
  
  fileprivate var url: URL?
  fileprivate var queryparams: [String: Any]? = nil
  fileprivate var method: HTTPMethod
  fileprivate var path: String
  fileprivate var parameters: [String: Any]?
  
  
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(
    url: URL? = RequestManager.base_url,
    queryparams: [String: Any]? = nil,
    method: HTTPMethod = .get,
    path: String...,
    parameters: [String: Any]? = nil
  ) {
    self.queryparams = queryparams
    self.url = url
    self.method = method
    self.parameters = parameters
    self.path = path.joined(separator: "/")
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  

  func getDataRequest() -> DataRequest {
    guard var url = url?.appendingPathComponent(path) else {
      fatalError("RequestManager: Something went wrong, url is null")
    }
    
    if let qItems = queryparams {
      url.addQueryParams(qItems)
    }
    
    return SessionManager.shared.request(url, method: method, parameters: parameters)
  }
  
  
  func requestCodableData<T:Codable>( completion: @escaping (Result<T, Error> ) -> Void) {
    getDataRequest().responseDecodable(of: T.self) { response in
      switch response.result {
        case .success(let value): return completion(.success(value))
        case .failure(let error): return completion(.failure(error))
      }
    }
  }
}



fileprivate extension URL {
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  mutating func addQueryParams( _ params: [String: Any]) {
    var components = URLComponents(string: self.absoluteString)
    components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value as? String) }
    if let auxURL = components?.url {
      self = auxURL
    }
  }
}
