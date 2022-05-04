//
//  ApodDetailController.swift
//  MovieDB
//
//  Created by Andres Lozano on 15/01/22.
//

import UIKit

class EntertainmentMediaDetailController: UIViewController {
  
  
  // ---------------------------------------------------------------------
  // MARK: Constants
  // ---------------------------------------------------------------------
  
  
  let viewModel: EntertainmentMediaDetailViewModel
  let spaceBtwContainerStackAndImage: CGFloat = 44
  
  
  // ---------------------------------------------------------------------
  // MARK: IBOutlets variables
  // ---------------------------------------------------------------------
  
  
  @IBOutlet var heightImageConstraint: NSLayoutConstraint!
  @IBOutlet var topScrollViewConstraint: NSLayoutConstraint!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var imageBackground: UIImageView!
  @IBOutlet var closeButton: UIButton!
  @IBOutlet var playButton: UIButton!
  @IBOutlet var containerPlayButtonView: UIView!
  
  
  // ---------------------------------------------------------------------
  // MARK: Variables
  // ---------------------------------------------------------------------
  
  
  var imageHeight: CGFloat {
    view.frame.height * 0.57
  }
  
  var topSafeAre: CGFloat {
    if #available(iOS 13.0, *) {
      let window = UIApplication.shared.windows.first
      return window?.safeAreaInsets.top ?? 0
    } else {
      let window = UIApplication.shared.keyWindow
      return window?.safeAreaInsets.top ?? 0
    }
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Constructor
  // ---------------------------------------------------------------------
  
  
  init(viewModel: EntertainmentMediaDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "EntertainmentMediaDetailController", bundle: nil)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Life cycle
  // ---------------------------------------------------------------------
  
  
  override func loadView() {
    super.loadView()
    closeButton.cornerRadius(closeButton.frame.width / 2)
    imageView.cornerRadius(0)
    playButton.cornerRadius(playButton.frame.height / 2)
    containerPlayButtonView.addShadow(
      radius: playButton.frame.height / 2,
      shadowRadius: 6,
      offset: .zero,
      borderWidth: 0.5,
      borderColor: .init(white: 0.3, alpha: 0.8)
    )
    setupConstraints()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: Helpers func
  // ---------------------------------------------------------------------
  
  
  private func setup() {
    scrollView.delegate = self
    setupCloseButton()
    setupPlayButton()
    populateData()
    viewModel.fetchVideos()
  }
  
  
  func setupCloseButton() {
    closeButton.removeFromSuperview()
    navigationItem.setHidesBackButton(true, animated: false)
    navigationItem.leftBarButtonItem = .init(customView: closeButton)
    navigationController?.interactivePopGestureRecognizer?.delegate = self
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
  
  
  private func populateData() {
    guard let item = viewModel.item.value else { return }
    descriptionLabel.text = item.getOverview()
    titleLabel.text = item.getName()
    setupImage(item.getPosterURL(width: .w500))
  }
  
  
  private func setupPlayButton() {
    playButton.setTitle("", for: [])
  }
  
  
  private func setupImage(_ value: URL?) {
    ImageManager.setImage(
      with: value,
      to: imageView,
      placeHolder: UIImage(named: "placeholder")
    ) {
      self.imageBackground.image = self.imageView.image
    }
  }
  
  
  private func setupConstraints() {
    heightImageConstraint.constant = imageHeight
    topScrollViewConstraint.constant = imageHeight - (topSafeAre + 16)
  }
  
  
  private func setupObservers() {
    viewModel.item.bind { [weak self] msj in
      self?.populateData()
    }
  }
  
  
  private func handleAlphaView(_ values: UIView ..., alpha: CGFloat) {
    values.forEach({
      $0.alpha = alpha
    })
  }
  
  
  // ---------------------------------------------------------------------
  // MARK: @IBActions
  // ---------------------------------------------------------------------
  
  
  @IBAction func closeActionButton(_ sender: UIButton) {
    viewModel.close()
  }
  
  
  @IBAction func playActionButton(_ sender: UIButton) {
    viewModel.playVideo()
  }
}



extension EntertainmentMediaDetailController: UIScrollViewDelegate, UIGestureRecognizerDelegate {
  
  
  // ---------------------------------------------------------------------
  // MARK: UIScrollViewDelegate
  // ---------------------------------------------------------------------
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let y = scrollView.contentOffset.y
    let realY = -(y + (topSafeAre + spaceBtwContainerStackAndImage))
    let offset = imageHeight + realY
    handleAlphaView(containerPlayButtonView, closeButton, alpha: offset / (imageHeight - topSafeAre))
    heightImageConstraint.constant = offset
  }
}

