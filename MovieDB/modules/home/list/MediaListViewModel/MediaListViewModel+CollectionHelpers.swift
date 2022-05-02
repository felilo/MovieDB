//
//  MediaListViewModel+ListHelpers.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation


extension MediaListViewModel {
  
  
  func numberOfRowsInSection(_ section: Int) -> Int {
    let item = getItemAt(.init(row: 0, section: section))
    return item?.value.isEmpty == true ? 0 : 1
  }
  
  
  func numberOfSections() -> Int {
    return listItems.count
  }
  
  
  func getItemAt(_ indexPath: IndexPath) -> ModelItem? {
    guard !listItems.isEmpty else { return nil }
    return listItems[indexPath.section]
  }
  
  
  func isHeaderHidden(section: Int) -> Bool {
    let items = getItemAt(.init(row: 0, section: section))
    return items?.value.isEmpty == true
  }
  
  
  func getHeaderTitle(_ indexPath: IndexPath) -> String? {
    guard let section = getItemAt(indexPath),
          let item = section.value.first
    else { return nil }
    return section.key.title + " \(item.getMediaType().title)"
  }
  
  
  func filterItems(_ value: String) {
    itemsFiltered = items.map { section -> ModelItem in
      var cSection = section
      cSection.value = section.value.filter({
        $0.exist(value: value)
      })
      return cSection
    }
    onFetchItems.value = true
  }
}
