//
//  EntertainmentTest.swift
//  MovieDBTests
//
//  Created by Andres Lozano on 27/04/22.
//

import XCTest
@testable import MovieDB


class MovieTest: XCTestCase {
  
  
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
  
  
  func test_check_match() {
    let sut = MovieModel(id: 1, title: "The batman", overview: "The Batman is a 2022 American superhero film based on the DC Comics character Batman.Produced by Warner Bros. Pictures, DC Films, 6th & Idaho, and Dylan Clark Productions")
    
    XCTAssertTrue(sut.exist(value: "batm"))
    XCTAssertTrue(sut.exist(value: "2022"))
    XCTAssertFalse(sut.exist(value: "fruta"))
  }
}
