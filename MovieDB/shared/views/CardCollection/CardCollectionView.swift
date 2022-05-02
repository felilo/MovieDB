//
//  MediaCollectionController.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import UIKit


class CardCollectionView: UICollectionView {

  
  typealias ModelItem = EntertainmentMediaItem
  
  
  // ---------------------------------------------------------------------
  // MARK: Constants
  // ---------------------------------------------------------------------
  

  let verticalInset: CGFloat = 10
  let CELL_ID = "cell_identifier"
  
  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------

  
  weak var mediaCollectionDelegate: MediaCollectionDelegate?
  var heightCollectionView: CGFloat = 0
  var items = Bindable<[ModelItem]>()
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(items: [ModelItem]) {
    self.items.value = items
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    super.init(frame: .zero, collectionViewLayout: layout)
    setup()
  }

  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  func setup() {
    register(.init(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: CELL_ID)
    contentInset = .init(top: verticalInset, left: 20, bottom: verticalInset, right: 20)
    backgroundColor = .clear
    dataSource = self
    delegate = self
    setupObservers()
  }
  
  
  private func updateCollection() {
    DispatchQueue.main.async { [weak self] in
      self?.reloadData()
    }
  }
  
  
  func setupObservers() {
    items.bind { [weak self] _ in
      self?.updateCollection()
    }
  }
}



protocol MediaCollectionDelegate: AnyObject {
  func onSelectedItem(_ item: EntertainmentMediaItem?) -> Void
}
