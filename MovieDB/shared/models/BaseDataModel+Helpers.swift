//
//  BaseDataModel.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation


/**
 constants that can be used to define the category to an entertainment media
 */
enum EntertainmentMediaCategory: String, CaseIterable {
  
  case popular, upcoming
  case topRated = "top_rated"
  
  var title: String {
    switch self {
      case .popular: return "Popular"
      case .topRated: return "Top Rated"
      case .upcoming: return "Upcoming"
    }
  }
  
//  func titleWithCategotyType(_ type: EntertainmentMediaType) -> String {
//    switch self {
//      case .popular: return "Popular (\(type.title))"
//      case .topRated: return "Top Rated (\(type.title))"
//      case .upcoming: return "Upcoming (\(type.title))"
//    }
//  }
}


/**
 constants that can be used to define the type to an entertainment media
 */
enum EntertainmentMediaType: String {
  
  case movie
  
  var title: String {
    switch self {
      case .movie: return "Movie"
    }
  }
}


/**
 constants that can be used to define the Width to an image
 */
enum ImageWidth: String {
  case w500, original
}


// this protocol execute the actions to changes properties' values
protocol EntertainmentMediaPropertyUpdater: AnyObject {
  func updateVideos(_ value: [VideoModel])
  func getVideos() -> [VideoModel]
}


/// A type that can convert itself into and out of an external representation.
///
/// `EntertainmentMediaItem` is a type alias for the `EntertainmentMediaPropertyUpdater` and `EntertainmentMediaDataSource` protocols.
protocol EntertainmentMediaItem: EntertainmentMediaPropertyUpdater, EntertainmentMediaDataSource { }


// this protocol represents the data model object. as such, it supplies no information about appearance (including the cells)
protocol EntertainmentMediaDataSource: AnyObject {
  func getName() -> String?
  func getOverview() -> String?
  func getPosterURL(width: ImageWidth) -> URL?
  func getId() -> Int?
  func exist(value: String) -> Bool
  func getMediaType() -> EntertainmentMediaType
}
