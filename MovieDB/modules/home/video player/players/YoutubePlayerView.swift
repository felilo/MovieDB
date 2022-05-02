//
//  YoutubePlayerVIew.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit
import youtube_ios_player_helper

class YoutubePlayerView: UIView, PlayerVideo, YTPlayerViewDelegate {

  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------
  
  
  let youtubePlayer: YTPlayerView
  let id: String
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  

  required init(id: String) {
    self.id = id
    youtubePlayer = .init()
    super.init(frame: .zero)
    setupPlayer()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  private func setupPlayer() {
    youtubePlayer.delegate = self
    addSubview(youtubePlayer)
    youtubePlayer.translatesAutoresizingMaskIntoConstraints = false
    [
      youtubePlayer.topAnchor.constraint(equalTo: topAnchor),
      youtubePlayer.bottomAnchor.constraint(equalTo: bottomAnchor),
      youtubePlayer.leadingAnchor.constraint(equalTo: leadingAnchor),
      youtubePlayer.trailingAnchor.constraint(equalTo: trailingAnchor)
    ].forEach({ $0.isActive = true })
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: YTPlayerViewDelegate
  // ---------------------------------------------------------------------
  

  func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
    playerView.playVideo()
  }
  
  func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
    debugPrint(error)
  }
  
  // ---------------------------------------------------------------------
  // MARK: Public funcs
  // ---------------------------------------------------------------------
  

  func start() {
    let pv: [String: Any] = [
      "playsinline": 1,
      "showinfo": 0,
      "modestbranding": 1,
      "autoplay": 1
    ]
    youtubePlayer.load(withVideoId: id, playerVars: pv)
  }
}
