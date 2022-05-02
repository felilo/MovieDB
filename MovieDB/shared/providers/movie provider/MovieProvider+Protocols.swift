//
//  MovieProvider+Helpers.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation


protocol MovieProviderProtocol {
  
  func list<T>(category: EntertainmentMediaCategory, handleSuccess: @escaping HandleSuccess<T>)
  func detail<T>(id: Int, handleSuccess: @escaping HandleSuccess<T>)
}
