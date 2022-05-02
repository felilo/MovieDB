//
//  MediaListViewCell.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import UIKit

class MediaListViewCell: DefaultCollectionCell<[EntertainmentMediaItem]> {
  
  
  // ---------------------------------------------------------------------
  // MARK: Views
  // ---------------------------------------------------------------------
  
  
  private let heightCollectionView: CGFloat = 140
  private var collectionView: CardCollectionView?
  weak var delegate: MediaCollectionDelegate?
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCollection()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  override func prepareForReuse() {
    resetValues()
    super.prepareForReuse()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  override func setup() {
    guard let items = item else { return }
    collectionView?.items.value = items
  }
  
  
  private func setupCollection() {
    collectionView = .init(items: [])
    addSubview(collectionView!)
    collectionView?.fillSuperview()
    collectionView?.mediaCollectionDelegate = self
    collectionView?.heightCollectionView = heightCollectionView
  }
  
  
  func resetValues() {
    collectionView?.items.value = []
    item = nil
  }
}



extension MediaListViewCell: MediaCollectionDelegate {
  func onSelectedItem(_ item: EntertainmentMediaItem?) {
    delegate?.onSelectedItem(item)
  }
}
