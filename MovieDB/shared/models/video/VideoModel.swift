//
//  VideoModel.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation

class VideoModel: Codable {
  
  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------

  
  private (set) var id: String?
  private (set) var name: String?
  private (set) var key: String?
  private (set) var site: Site?
  var mediaId: Int?
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  

  init(id: String?, name: String?, key: String?, site: Site?, mediaId: Int? = nil) {
    self.id = id
    self.site = site
    self.key = key
    self.name = name
    self.mediaId = mediaId
  }

  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  

  enum Site: String, Codable {
    case youtube = "YouTube"
    case vimeo = "Vimeo"
  }
}
