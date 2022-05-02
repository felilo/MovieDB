//
//  DetailMediaViewModelTest.swift
//  MovieDBTests
//
//  Created by Andres Lozano on 30/04/22.
//

import XCTest
@testable import MovieDB

class DetailMediaViewModelTest: XCTestCase {
  
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  private let movieModel = MovieModel.init(
    id: 675445,
    title: "title test",
    posterPath: "/ic0intvXZSfBlYPIvWXpU1ivUCO.jpg",
    overview: "lorem impsum",
    category: .upcoming
  )
  
  
  private let provider = VideoProvider()
  
  
  let homeCoordinator: HomeCoordinator = {
    let parentCoordinator = (UIApplication.shared.delegate as? AppDelegate)?.mainCoordinator
    return .init(withPresent: parentCoordinator!)
  }()
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  override func setUp() {
    super.setUp()
  }
  
  
  override func tearDown() {
    super.tearDown()
  }
  
  
  func test_fetch_videos() throws  {
    let sut = EntertainmentMediaDetailViewModel(coordinator: homeCoordinator, provider: provider, item: movieModel)
    let expt = XCTestExpectation()
    
    sut.onFetchVideos.bind { result in
      XCTAssertTrue(result ?? false)
      expt.fulfill()
    }
    
    sut.onError.bind { result in
      if !RequestManager.isAvailableNetwork {
        XCTAssertTrue(true)
      } else {
        XCTFail("Expected to be a success but got a failure with: \(result ?? "-")")
      }
      expt.fulfill()
    }
    sut.fetchVideos()
    self.wait(for: [expt], timeout: 15)
  }
}
