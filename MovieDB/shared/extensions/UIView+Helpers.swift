//
//  UIView+Helpers.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit

extension UIView {
  
  func addShadow(
    radius: CGFloat = 25,
    shadowRadius: CGFloat = 9,
    shadowOpacity: Float = 0.8,
    shadowColor: UIColor = UIColor(white: 0.3, alpha: 0.8),
    offset: CGSize = CGSize(width: 0, height: 8),
    borderWidth: CGFloat = 0,
    borderColor: UIColor? = nil
  ) {
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = shadowOpacity
    layer.shadowOffset =  offset
    layer.shadowRadius = shadowRadius
    layer.shouldRasterize = true
    layer.masksToBounds = false
    layer.cornerRadius = radius
    layer.rasterizationScale = UIScreen.main.scale
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor?.cgColor
  }
  
  
  func cornerRadius(_ value: CGFloat) {
    layer.masksToBounds = true
    clipsToBounds = true
    layer.cornerRadius = value
  }
  
  
  func fillSuperview(padding: UIEdgeInsets = .zero){
    guard let superview = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top),
      self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom),
      self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left),
      self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right)
    ])
  }
}
