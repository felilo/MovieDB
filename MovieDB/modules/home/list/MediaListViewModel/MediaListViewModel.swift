//
//  MediaListViewModel.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import Foundation


class MediaListViewModel: NSObject {
  
  
  typealias ModelItem = (key: EntertainmentMediaCategory, value: [EntertainmentMediaItem])
  
  
  // ---------------------------------------------------------------------
  // MARK: Constants
  // ---------------------------------------------------------------------
  
  
  private let coordinator: HomeCoordinator?
  private let provider: MovieProvider
  let title = "The movie DB"
  
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  private (set) var items: [ModelItem] = []
  var itemsFiltered: [ModelItem] = []
  var onFetchItems = Bindable<Bool>()
  var onError = Bindable<String>()
  
  var listItems:[ModelItem] {
    return (isFiltering ? itemsFiltered : items)
  }
  
  var isFiltering: Bool = false {
    didSet {
      if !isFiltering {
        itemsFiltered.removeAll()
      }
    }
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(coordinator: HomeCoordinator, provider: MovieProvider){
    self.coordinator = coordinator
    self.provider = provider
    super.init()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  func fetchItems() {
    EntertainmentMediaCategory.allCases.forEach { category in
      fetchItemsWith(category: category)
    }
  }
  
  
  func fetchItemsWith(category: EntertainmentMediaCategory) {
    provider.getItems(category: category) { [weak self] response in
      self?.handleResponse(response: response, category: category)
    }
  }
  
  
  func onSelectedItem(_ item: EntertainmentMediaItem?) {
    guard let item = item else { return }
    coordinator?.showDetail(item: item)
  }
  
  
  func handleResponse(response: Result<[MovieModel], Error>, category: EntertainmentMediaCategory) {
    switch response {
      case .success(let result): handleSuccessResult(category, items: result)
      case .failure(let error): handleErrorResult(error)
    }
  }
  
  
  private func handleSuccessResult(_ category: EntertainmentMediaCategory, items: [EntertainmentMediaItem]) {
    if let index = self.items.firstIndex(where: { $0.key == category }) {
      self.items[index].value = items
    } else {
      self.items.append((key: category, value: items))
    }
    onFetchItems.value = true
  }
  
  
  private func handleErrorResult(_ error: Error) {
    onError.value = error.localizedDescription
    coordinator?.showAlert(
      title: "Opps",
      message: error.localizedDescription
    )
    
  }
}




