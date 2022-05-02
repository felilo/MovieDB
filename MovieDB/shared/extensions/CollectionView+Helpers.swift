//
//  CollectionView+Helpers.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit

extension UICollectionView {
  
  func beginRefreshing() {
    // Make sure that a refresh control to be shown was actually set on the view
    // controller and the it is not already animating. Otherwise there's nothing
    // to refresh.
    guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
      return
    }
    
    // Start the refresh animation
    refreshControl.beginRefreshing()
    
    // Make the refresh control send action to all targets as if a user executed
    // a pull to refresh manually
    refreshControl.sendActions(for: .valueChanged)
    
    // Apply some offset so that the refresh control can actually be seen
    let height = (frame.height / 6) // refreshControl.frame.height + contentInset.top
    let contentOffset = CGPoint(x: -contentInset.left, y: -height)
    setContentOffset(contentOffset, animated: true)
  }
  
  func endRefreshing() {
    refreshControl?.endRefreshing()
  }
  
  
}
