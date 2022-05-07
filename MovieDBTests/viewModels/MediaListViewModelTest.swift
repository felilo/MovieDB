//
//  MediaListViewModel.swift
//  MovieDBTests
//
//  Created by Andres Lozano on 30/04/22.
//

import XCTest

@testable import MovieDB
class MediaListViewModelTest: XCTestCase {
  
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  private let homeCoordinator: HomeCoordinator = {
    let parentCoordinator = (UIApplication.shared.delegate as? AppDelegate)?.mainCoordinator
    return .init(present: parentCoordinator!)
  }()
  
  
  let provider: MovieProvider =  MovieProvider()
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  override func setUp() {
    super.setUp()
  }
  
  
  override func tearDown() {
    super.tearDown()
  }
  
  
  func test_fetch_popular_videos() throws  {
    let sut = MediaListViewModel(coordinator: homeCoordinator, provider: provider)
    let expt = XCTestExpectation()
    handleFetchVideoByy(sut: sut, category: .popular, expt: expt)
    wait(for: [expt], timeout: 15)
  }
  
  
  func test_fetch_topRated_videos() throws  {
    let sut = MediaListViewModel(coordinator: homeCoordinator, provider: provider)
    let expt = XCTestExpectation()
    handleFetchVideoByy(sut: sut, category: .topRated, expt: expt)
    wait(for: [expt], timeout: 15)
  }
  
  
  func test_fetch_upcoming_videos() throws  {
    let sut = MediaListViewModel(coordinator: homeCoordinator, provider: provider)
    let expt = XCTestExpectation()
    handleFetchVideoByy(sut: sut, category: .upcoming, expt: expt)
    wait(for: [expt], timeout: 15)
  }
  
  
  private func handleFetchVideoByy(sut: MediaListViewModel, category: EntertainmentMediaCategory, expt: XCTestExpectation)  {
    
    if !RequestManager.isAvailableNetwork {
      XCTAssertTrue(true)
      expt.fulfill()
      return
    }
    
    sut.onFetchItems.bind { result in
      XCTAssertNotNil(sut.listItems.first(where: { $0.key == category }))
      expt.fulfill()
    }
    
    sut.onError.bind { result in
      if !RequestManager.isAvailableNetwork {
        XCTAssertTrue(true)
      } else {
        XCTFail("Expected to be a success but got a failure with: \(result ?? "-")")
      }
    }
    
    sut.fetchItemsWith(category: category)
  }
}
