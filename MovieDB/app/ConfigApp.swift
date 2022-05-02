//
//  Config.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation


struct ConfigApp: Codable {
  
  
  // ---------------------------------------------------------------------
  // MARK: Constants
  // ---------------------------------------------------------------------
  
  
  static let shared = DefaultSetup()
  
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  var baseURL: String
  var imageURL: String
  var apiToken: String
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers
  // ---------------------------------------------------------------------
  
  
  enum CodingKeys: String, CodingKey {
    case baseURL = "base_url"
    case imageURL = "image_url"
    case apiToken = "api_token"
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Static funcs
  // ---------------------------------------------------------------------
  
  
  static func DefaultSetup() -> ConfigApp {
    
    guard let url = Bundle.main.url(forResource: "Config", withExtension: "plist")
    else { fatalError("Could not find Config.plist in your bundle") }
    
    guard let data = try? Data(contentsOf: url),
          let item = try? PropertyListDecoder().decode(ConfigApp.self, from: data)
    else { fatalError("Something went wrong, please check your Config.plist file") }
    
    return item
  }
  
  
  static func Api () {
    RequestManager.handleGetToken = {
      return ConfigApp.shared.apiToken
    }
  }
}
