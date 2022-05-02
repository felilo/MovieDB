//
//  VideoProviderTests.swift
//  MovieDBTests
//
//  Created by Andres Lozano on 29/04/22.
//


import XCTest
@testable import MovieDB

class VideoProviderTests: XCTestCase {
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  let id = 436969
  
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  override func setUp() {
    super.setUp()
  }
  
  
  override func tearDown() {
    super.tearDown()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Tests
  // ---------------------------------------------------------------------
  
  
  func test_list_movie() throws {
    let sut = VideoProvider(dataSource: .api)
    let expt = XCTestExpectation()
    sut.getList(mediaId: id, type: .movie) { response in
      switch response {
        case .success(let result):
          XCTAssertTrue(!result.isEmpty, "finalizo el assert true")
          expt.fulfill()
        case .failure(let error):
          if !RequestManager.isAvailableNetwork {
            XCTAssertTrue(true)
          } else {
            XCTFail("Expected to be a success but got a failure with: \(error.localizedDescription)\n\n")
          }
          expt.fulfill()
          break
      }
    }
    wait(for: [expt], timeout: 15)
  }
}
