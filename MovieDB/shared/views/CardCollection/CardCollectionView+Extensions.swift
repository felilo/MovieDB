//
//  MediaCollectionView+Extensions.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit


extension CardCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  
  // ---------------------------------------------------------------------
  // MARK: UICollectionViewDataSource
  // ---------------------------------------------------------------------
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.value?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CELL_ID,
      for: indexPath
    ) as? CardViewCell else {
      fatalError("MediaListViewCell is not exist")
    }
    
    cell.item = items.value?[indexPath.item]
    return cell
  }
  
  // ---------------------------------------------------------------------
  // MARK: UICollectionViewDelegate
  // ---------------------------------------------------------------------
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    mediaCollectionDelegate?.onSelectedItem(items.value?[indexPath.item])
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: UICollectionViewDelegateFlowLayout
  // ---------------------------------------------------------------------
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 250, height: frame.height - 51)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 25
  }
 
}

