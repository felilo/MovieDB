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
  

  let id = 436969
  var sut: MovieProvider!
  var expt: XCTestExpectation!

  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------

  
  override func setUp() {
    sut = .init()
    expt = XCTestExpectation()
    super.setUp()
  }
  
  
  override func tearDown() {
    sut = nil
    expt = nil
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
            if !RequestManager.isAvailableNetwork {
              XCTAssertTrue(true, "Fail but network is not working")
            } else {
              XCTFail("Expected to be a success but got a failure with: \(error.localizedDescription)\n\n")
            }
            cExpt.fulfill()
            break
        }
      }
      expts.append(cExpt)
    }
    wait(for: expts, timeout: 50)
  }
  
  
  func test_detail_endpoint() throws {
    sut.getDetail(id: id) { response in
      switch response {
        case .success(let result):
          XCTAssertTrue(result.id != nil, "finalizo el detail, el id es null")
          self.expt.fulfill()
        case .failure(let error):
          if !RequestManager.isAvailableNetwork {
            XCTAssertTrue(true, "Fail but network is not working")
          } else {
            XCTFail("Expected to be a success but got a failure with: \(error.localizedDescription)\n\n")
          }
          self.expt.fulfill()
          break
      }
    }
    wait(for: [expt], timeout: 5)
  }
}
