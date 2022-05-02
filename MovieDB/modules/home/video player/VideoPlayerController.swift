//
//  VideoPlayerController.swift
//  MovieDB
//
//  Created by Andres Lozano on 1/05/22.
//

import UIKit


class VideoPlayerController: UIViewController {
  
  
  // ---------------------------------------------------------------------
  // MARK: IBOutlets variables
  // ---------------------------------------------------------------------
  

  @IBOutlet var containerStack: UIStackView!
  
  
  // ---------------------------------------------------------------------
  // MARK: Properties
  // ---------------------------------------------------------------------
  
  
  
  private let viewModel: VideoPlayerViewModel
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  

  init(viewModel: VideoPlayerViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "VideoPlayerController", bundle: nil)
    setupObservers()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.setupPlayer()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  

  private func setupObservers() {
    
    viewModel.onPlayer.bind { [weak self] _ in
      self?.handleOnPlayer()
    }
    
    viewModel.onError.bind { [weak self] _ in
      self?.viewModel.close()
    }
  }
  
  
  private func handleOnPlayer() {
    guard let value = viewModel.playerVideo else { return }
    containerStack.addArrangedSubview(value)
    viewModel.startPlayer()
  }
  
  
  @IBAction func closeBtnAction(_ sender: UIButton) {
    viewModel.close()
  }
}
