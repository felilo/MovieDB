//
//  Player+Protocols.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit


protocol PlayerVideo: UIView {
  
  init(id: String)
  func start() -> Void
}
