//
//  MediaViewCell.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import UIKit


class CardViewCell: DefaultCollectionCell<EntertainmentMediaDataSource> {

  
  // ---------------------------------------------------------------------
  // MARK: IBOutlets variables
  // ---------------------------------------------------------------------
  

  @IBOutlet var imageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var overviewLabel: UILabel!
  @IBOutlet var containerView: UIView!

  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  override var isHighlighted: Bool {
    didSet { handleTransform() }
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    addShadow(radius: 4)
    containerView.cornerRadius(12)
  }
 
  
  override func prepareForReuse() {
    self.item = nil
    super.prepareForReuse()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  override func setup() {
    guard let item = item else { return }
    setTextLabel(value: item.getName(), item: titleLabel)
    setTextLabel(value: item.getName(), item: titleLabel)
    
    overviewLabel.text = item.getOverview()
    ImageManager.setImage(
      with: item.getPosterURL(width: .w500),
      to: imageView,
      placeHolder: UIImage(named: "placeholder")
    )
  }
  
  
  func setTextLabel(value: String?, item: UILabel) {
    item.isHidden = value == nil
    item.text = value
  }
  
  
  private func handleTransform() {
    var transform: CGAffineTransform = .identity
    if isHighlighted {
      transform = .init(scaleX: 0.93, y: 0.93)
    }
    UIView.animate(
      withDuration: 0.8,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 1,
      options: .curveEaseOut,
      animations: {
        self.transform = transform
      }
    )
  }
  
}

