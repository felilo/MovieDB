//
//  MediaListController.swift
//  MovieDB
//
//  Created by Andres Lozano on 30/04/22.
//

import UIKit


class MediaListController: UICollectionViewController {
  
  
  // ---------------------------------------------------------------------
  // MARK: Constants
  // ---------------------------------------------------------------------
  
  
  private let KindHeader = UICollectionView.elementKindSectionHeader
  private let CELL_ID = "cell_identifier"
  private let HEADER_ID = "header_identifier"
  let height: CGFloat = 230
  let viewModel: MediaListViewModel
  
  
  // ---------------------------------------------------------------------
  // MARK: Views
  // ---------------------------------------------------------------------
  
  
  private var searchController: UISearchController?
  
  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------
  
  
  var timer: Timer?
  var collectionInsets: UIEdgeInsets = .zero
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(viewModel: MediaListViewModel) {
    self.viewModel = viewModel
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = viewModel.title
    setupObservers()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      self?.collectionView.beginRefreshing()
    }
  }
  
  
  override func loadView() {
    super.loadView()
    setupSearchController()
    setupRefreshCtrlCollection()
    setupCollection()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  private func setupCollection() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MediaListViewCell.self, forCellWithReuseIdentifier: CELL_ID)
    collectionView.register(MediaHeaderView.self, forSupplementaryViewOfKind: KindHeader, withReuseIdentifier: HEADER_ID)
    collectionView.backgroundColor = UIColor(named: "backgroundContainer")
  }
  
  
  private func setupRefreshCtrlCollection() {
    collectionView.refreshControl = UIRefreshControl()
    collectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }
  
  
  private func setupSearchController(){
    searchController = .init(searchResultsController: nil)
    searchController?.obscuresBackgroundDuringPresentation = false
    definesPresentationContext = true
    navigationItem.searchController = searchController
    searchController?.searchResultsUpdater = self
    searchController?.searchBar.delegate = self
    searchController?.hidesNavigationBarDuringPresentation = false
    searchController?.searchBar.sizeToFit()
  }
  
  
  @objc private func refresh( ) {
    DispatchQueue.main.async { [weak self] in
      self?.handleOnPullToRefresh()
    }
  }
  
  
  private func setupObservers() {
    
    viewModel.onFetchItems.bind { [weak self] reloadData in
      DispatchQueue.main.async{ [weak self] in
        self?.handleOnFetchItems(reloadData)
      }
    }
    
    viewModel.onError.bind { [weak self] msj in
      self?.handleOnError(message: msj)
    }
  }
  
  
  private func handleOnFetchItems(_ reloadData: Bool?) {
      
    guard reloadData == true else {
      collectionView.endRefreshing()
      collectionView.perform(#selector(collectionView.reloadSectionWithDelay), with: nil, afterDelay: 0.05)
      return
    }
    collectionView.endRefreshing()
    collectionView.perform(#selector(collectionView.reloadData), with: nil, afterDelay: 0.05)
  }
  
  
  private func handleOnPullToRefresh() {
    viewModel.fetchItems()
  }
  
  
  private func handleOnError(message: String?) {}
  
  
  // ---------------------------------------------------------------------
  // MARK: UICollectionViewDataSource
  // ---------------------------------------------------------------------
  
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.numberOfSections()
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection(section)
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CELL_ID,
      for: indexPath
    ) as? MediaListViewCell else {
      fatalError("MediaListViewCell is not exist")
    }
    
    cell.item = viewModel.getItemAt(indexPath)?.value
    cell.delegate = self
    return cell
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: KindHeader,
      withReuseIdentifier: HEADER_ID,
      for: indexPath
    ) as? MediaHeaderView else {
      fatalError("MediaHeaderView is not exist")
    }
    
    header.setText(viewModel.getHeaderTitle(indexPath))
    return header
  }
}
