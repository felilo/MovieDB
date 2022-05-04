//
//  CollectionView+Helpers.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit

extension UICollectionView {
  
  
  func beginRefreshing() {
    guard let refreshControl = refreshControl,
            !refreshControl.isRefreshing
    else { return }
    let height = (frame.height / 6)
    let contentOffset = CGPoint(x: -contentInset.left, y: -height)
    refreshControl.beginRefreshing()
    setContentOffset(contentOffset, animated: true)
    refreshControl.sendActions(for: .valueChanged)
  }
  
  
  @objc func reloadSectionWithDelay() {
    for item in (0..<numberOfSections) {
      reloadSections(IndexSet.init(integer: item))
    }
  }
  
  
  func endRefreshing() {
    refreshControl?.endRefreshing()
  }
}
