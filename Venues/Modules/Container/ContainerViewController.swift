//
//  ViewController.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//

import UIKit

class ContainerViewController: UIViewController {

  private lazy var dependencies: AppDependencies = {
    let apiClient = APIClient(baseURL: NetworkConstants.baseURL)
    // swiftlint:disable:next force_cast
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let persitenceService = PersistenceService(persistentContainer: persistentContainer)
    let locationService = LocationManager()
    let dependecies = AppDependencies(
      networkClient: apiClient,
      persistenceService: persitenceService,
      locationManager: locationService)
    return dependecies
  }()

  private lazy var topToolBar: TopToolbarView = {
    let toolbar = TopToolbarView()
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    toolbar.delegate = self
    return toolbar
  }()

  private lazy var pageViewController: MainPageViewController = {
    let viewController = MainPageViewController(dependencies: dependencies)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    viewController.swipeDelegate = self
    return viewController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviewsAndConstraints()
  }

  private func setupSubviewsAndConstraints() {
    view.backgroundColor = .white
    view.addSubview(topToolBar)
    view.addSubview(pageViewController.view)

    topToolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    topToolBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    topToolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    topToolBar.heightAnchor.constraint(equalToConstant: 30).isActive = true

    pageViewController.view.topAnchor.constraint(equalTo: topToolBar.bottomAnchor, constant: 10).isActive = true
    pageViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    pageViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    pageViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
}

extension ContainerViewController: TopToolbarViewDelegate {
  func didSelectIndex(_ view: TopToolbarView, choice: SegmentedChoice) {
    pageViewController.switchController(choice)
  }
}

extension ContainerViewController: MainPageViewControllerDelegate {
  func didSwipeTo(_ viewController: MainPageViewController, choice: SegmentedChoice) {
    topToolBar.switchSelectedIndex(choice)
  }

}
