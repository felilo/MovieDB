//
//  ImageManager.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation
import SDWebImage

class ImageManager {
  
  
  class func setImage(
    with url: URL?,
    to imageView: UIImageView,
    placeHolder: UIImage? = nil,
    completation: ( () -> () )? = nil
  ) {
    
    DispatchQueue.main.async {
      imageView.sd_setImage(
        with: url,
        placeholderImage: placeHolder
      ) { _,_,_,_  in
        completation?()
      }
    }
  }
}
