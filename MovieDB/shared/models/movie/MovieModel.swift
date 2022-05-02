//
//  MovieModel.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation


class MovieModel: Codable {
  
  
  // ---------------------------------------------------------------------
  // MARK: Atributes
  // ---------------------------------------------------------------------
  
  
  private (set) var id: Int?
  private (set) var overview: String?
  private (set) var posterPath: String?
  private (set) var title: String?
  var category: EntertainmentMediaCategory?
  var videos: [VideoModel] = []
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  

  init(
    id: Int? = nil,
    title: String? = nil,
    posterPath: String? = nil,
    overview: String? = nil,
    category: EntertainmentMediaCategory? = nil
  ) {
    self.id = id
    self.posterPath = posterPath
    self.overview = overview
    self.title = title
    self.category = category
  }
  
  
  private enum CodingKeys: String, CodingKey {
    case id, overview, title
    case posterPath = "poster_path"
  }
}



