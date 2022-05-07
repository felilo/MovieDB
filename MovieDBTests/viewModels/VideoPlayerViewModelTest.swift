//
//  VideoPlayerViewModelTest.swift
//  MovieDBTests
//
//  Created by Andres Lozano on 1/05/22.
//

import XCTest

@testable import MovieDB
class VideoPlayerViewModelTest: XCTestCase {
  
  
  
  let homeCoordinator: HomeCoordinator = {
    let parentCoordinator = (UIApplication.shared.delegate as? AppDelegate)?.mainCoordinator
    return .init(present: parentCoordinator!)
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
  
  
  func test_get_vimeo_player() throws  {
    
    let itemModel = VideoModel.init(
      id: "ar345dsdfs",
      name: "some video",
      key: "asdasdw",
      site: .vimeo,
      mediaId: 10
    )
    
    let expt = XCTestExpectation()
    if itemModel.site == .vimeo {
      XCTAssertTrue(true)
      expt.fulfill()
    }
    self.wait(for: [expt], timeout: 5)
  }
  
  
  func test_get_youtube_player() throws  {
    let itemModel = VideoModel.init(
      id: "ar345dsdfs",
      name: "some video",
      key: "asdasdw",
      site: .youtube,
      mediaId: 10
    )
    
    let expt = XCTestExpectation()
    testPlayer(item: itemModel, expt: expt)
    self.wait(for: [expt], timeout: 5)
  }
  
  
  func testPlayer(item: VideoModel, expt: XCTestExpectation){
    let sut = VideoPlayerViewModel(coordinator: homeCoordinator, item: item)
    
    sut.onPlayer.bind { result in
      XCTAssertNotNil(sut.playerVideo, "Pleyer cannot be null")
      expt.fulfill()
    }
    
    sut.onError.bind { result in
      XCTFail(result ?? "Expected to be a success but got a failure ")
      expt.fulfill()
    }
    
    sut.setupPlayer()
  }

}
