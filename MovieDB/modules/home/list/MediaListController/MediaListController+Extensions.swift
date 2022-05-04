//
//  MediaListController+Extensions.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import UIKit


extension MediaListController: MediaCollectionDelegate {
  
  
  // ---------------------------------------------------------------------
  // MARK: MediaCollectionDelegate
  // ---------------------------------------------------------------------
  
  
  func onSelectedItem(_ item: EntertainmentMediaItem?) {
    viewModel.onSelectedItem(item)
  }
}



extension MediaListController: UISearchResultsUpdating, UISearchBarDelegate {
  
  
  // ---------------------------------------------------------------------
  // MARK: UISearchResultsUpdating - UISearchBarDelegate
  // ---------------------------------------------------------------------
  
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { [weak self] _ in
      self?.viewModel.filterItems(searchText)
    }
  }
  
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.onCancelSearch(text: searchBar.text)
  }
  
  
  func updateSearchResults(for searchController: UISearchController) { }
}



extension MediaListController: UICollectionViewDelegateFlowLayout {
  
  
  // ---------------------------------------------------------------------
  // MARK: UICollectionViewDelegateFlowLayout
  // ---------------------------------------------------------------------
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = viewModel.numberOfRowsInSection(indexPath.section) == 0 ? 0 : height
    return CGSize(width: view.frame.width, height: height)
  }
  
  
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return collectionInsets
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let height: CGFloat = viewModel.isHeaderHidden(section: section) ? 0 : 40
    return .init(width: self.view.frame.width, height: height)
  }
}
