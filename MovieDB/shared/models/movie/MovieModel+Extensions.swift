//
//  MovieModel+Extensions.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation



extension MovieModel: EntertainmentMediaItem {
  
  
  // ---------------------------------------------------------------------
  // MARK: EntityModelHelpers
  // ---------------------------------------------------------------------
  
  
  func getName() -> String? {
    return title
  }
  
  
  func getOverview() -> String? {
    return overview
  }
  
  
  func getMediaType() -> EntertainmentMediaType {
    return .movie
  }
  
  
  func getPosterURL(width: ImageWidth) -> URL? {
    
    guard let path = posterPath
    else { return nil }
    
    let strUrl = [ConfigApp.shared.imageURL, width.rawValue].joined(separator: "/")
    let url = URL(string: strUrl + path)
    return url
  }
  
  
  func getId() -> Int? {
    return id
  }
  
  
  func exist(value: String) -> Bool {
    return title?.lowercased().contains(value.lowercased()) == true ||
    overview?.lowercased().contains(value.lowercased()) == true || value.isEmpty
  }
  
  
  func updateVideos(_ value: [VideoModel]) {
    videos = value
  }
  
  
  func getVideos() -> [VideoModel] {
    videos
  }
}
