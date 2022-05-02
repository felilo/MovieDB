//
//  MediaHeaderView.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import UIKit

class MediaHeaderView: UICollectionReusableView {
  
  
  // ---------------------------------------------------------------------
  // MARK: Views
  // ---------------------------------------------------------------------
  
  
  private let containerStackView: UIStackView = {
    let item = UIStackView(arrangedSubviews: [])
    item.axis = .horizontal
    return item
  }()
  
  
  private let titleLabel: UILabel = {
    let item = UILabel()
    item.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
    item.numberOfLines = 1
    item.textColor = .darkGray
    return item
  }()
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  private func setup() {
    layer.backgroundColor = UIColor.clear.cgColor
    addSubview(containerStackView)
    containerStackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 0))
    containerStackView.addArrangedSubview(titleLabel)
  }
  
  
  func setText(_ value: String?) {
    setup()
    titleLabel.text = value
  }
}
