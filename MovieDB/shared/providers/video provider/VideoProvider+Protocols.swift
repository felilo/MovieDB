//
//  MovieProvider+Helpers.swift
//  MovieDB
//
//  Created by Andres Lozano on 27/04/22.
//

import Foundation



protocol VideoProviderProtocol {
  
  func list<T>(mediaId: Int, type: EntertainmentMediaType, handleSuccess: @escaping HandleSuccess<T>)
}
