//
//  Provider+Helpers.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation


/**
 * Is an Alias to simplify writing asynchronous responses in providers
 */
typealias HandleSuccess<T:Codable> =  (Result<T, Error>) -> Void


/**
 * Handler to get array items when the response has a "results" key
 */
struct HandleListResult<T: Codable>: Codable {
  
  var items:T
  
  enum CodingKeys: String, CodingKey {
    case items = "results"
  }
  
}
