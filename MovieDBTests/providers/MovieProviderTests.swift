//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Andres Lozano on 27/04/22.
//

import XCTest
@testable import MovieDB

class MovieProviderTests: XCTestCase {
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  

  var sut: MovieProvider!

  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------

  
  override func setUp() {
    sut = .init()
    super.setUp()
  }
  
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Tests
  // ---------------------------------------------------------------------
  
  
  func test_list_endpoint() throws {
    let categories: [EntertainmentMediaCategory] = [.popular, .topRated, .upcoming]
    var expts = [XCTestExpectation]()
    
    categories.forEach { type in
      let cExpt: XCTestExpectation = .init()
      sut.getItems(category: type) { response in
        switch response {
          case .success:
            XCTAssertTrue(true)
            cExpt.fulfill()
          case .failure(let error):
            self.handleError(expt: cExpt, error: error)
        }
      }
      expts.append(cExpt)
    }
    wait(for: expts, timeout: 50)
  }
  
  
  func test_detail_endpoint() throws {
    let expt = XCTestExpectation()
    let id = 436969
    
    sut.getDetail(id: id) { response in
      switch response {
        case .success(let result):
          XCTAssertTrue(result.id != nil)
          expt.fulfill()
        case .failure(let error):
          self.handleError(expt: expt, error: error)
      }
    }
    wait(for: [expt], timeout: 5)
  }
  
  
  
  func handleError(expt: XCTestExpectation, error: Error) {
    if !RequestManager.isAvailableNetwork {
      XCTAssertTrue(true, "Fail but network is not working")
    } else {
      XCTFail("Expected to be a success but got a failure with: \(error.localizedDescription)\n\n")
    }
    expt.fulfill()
  }
}
