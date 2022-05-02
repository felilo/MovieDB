//
//  EntertainmentTest.swift
//  MovieDBTests
//
//  Created by Andres Lozano on 27/04/22.
//

import XCTest
@testable import MovieDB


class ModelsTest: XCTestCase {
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  

  override func setUp() {
    super.setUp()
  }
  
  
  override func tearDown() {
    super.tearDown()
  }
  
  
  func test_checkUrl_movie() throws {
    let sut = MovieModel(id: 1, posterPath: "/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg", overview: "__")
    XCTAssertEqual("https://image.tmdb.org/t/p/w500/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg", sut.getPosterURL(width: .w500)?.absoluteString)
  }
}
