//
//  VenuesViewController.swift
//  Venues
//
//  Created by Bruno Frani on 30.3.22.
//

import UIKit
import Combine

class VenuesViewController: UIViewController {

  private let viewModel: VenuesViewModel
  private var childView: VenuesView!
  private var subscriptions = Set<AnyCancellable>()

  init(dependencies: AppDependencies) {
    let viewModel = VenuesViewModel(dependencies: dependencies)
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    let venuesView = VenuesView()
    childView = venuesView
    view = childView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.getStoredVenues()
    viewModel.requestLocationPermissionAthorization()
    bindViewModel()
  }

  private func bindViewModel() {
    viewModel.$state.sink { [weak self] state in
      self?.updateViewForState(state)
    }.store(in: &subscriptions)
  }

  private func updateViewForState(_ state: ViewModelState) {
    switch state {
    case .initial:
      break
    case .loading:
      displayAnimatedActivityIndicatorView()
    case .data(let venues):
      guard let venues = venues as? [VenueInfo] else { return }
      applySnapshot(data: venues)
      hideAnimatedActivityIndicatorView()
    case .empty:
      applySnapshot(data: [])
      hideAnimatedActivityIndicatorView()
    case .error(let error):
      hideAnimatedActivityIndicatorView()
      showAlert(alertText: "Error", alertMessage: error.localizedDescription.description, buttonText: "Ok")
    }
  }

  private func applySnapshot(data: [VenueInfo]) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, VenueInfo>()
    snapshot.appendSections([1])
    snapshot.appendItems(data, toSection: 1)
    childView.diffableDataSource.apply(snapshot)
  }
}
