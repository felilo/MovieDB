//
//  DefaultCell.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit

open class DefaultCollectionCell<T>: UICollectionViewCell {
  
  
  // ---------------------------------------------------------------------
  // MARK: variables
  // ---------------------------------------------------------------------
  
  
  lazy private var width: NSLayoutConstraint = {
    let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
    width.isActive = true
    return width
  }()
  
  
  open var item: T? {
    didSet { setup() }
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    _setup()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    _setup()
  }
  
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  open override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    width.constant = bounds.size.width
    return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  private func _setup() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight]
  }
  
  
  open func setup() { }
}
