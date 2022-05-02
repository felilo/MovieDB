//
//  Bindable.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation


open class Bindable<T> {
  
  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------
  
  
  open var value: T? {
    didSet { observer?(value) }
  }
  
  open var observer:((T?)-> ())?
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  public init() {}
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  open func bind(observer: @escaping (T?) -> ()) -> Void {
    self.observer = observer
  }
}
