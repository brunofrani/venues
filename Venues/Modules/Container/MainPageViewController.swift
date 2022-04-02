//
//  MainPageViewController.swift
//  Venues
//
//  Created by Bruno Frani on 30.3.22.
//

import UIKit

protocol MainPageViewControllerDelegate: AnyObject {
  func didSwipeTo(_ viewController: MainPageViewController, choice: SegmentedChoice)
}

class MainPageViewController: UIPageViewController {

  let aboutUsViewController: AboutUsViewController
  let venuesViewController: VenuesViewController
  weak var swipeDelegate: MainPageViewControllerDelegate?
  private let dependecies: AppDependencies

  init(dependencies: AppDependencies) {
    self.dependecies = dependencies
    aboutUsViewController = AboutUsViewController()
    venuesViewController = VenuesViewController(dependencies: dependencies)
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource = self
    delegate = self
    view.backgroundColor = .white
    setViewControllers([venuesViewController], direction: .forward, animated: true, completion: nil)
  }

  func switchController(_ segmentedChoice: SegmentedChoice) {

    switch segmentedChoice {
    case .venues:
      goToPreviousPage()
    case .aboutUs:
      goToNextPage()
    }
  }
}

// MARK: Data source
// swiftlint:disable line_length
extension MainPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

    if viewController == venuesViewController {
      return nil
    } else if viewController == aboutUsViewController {
      return venuesViewController
    } else {
      return nil
    }
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

    if viewController == venuesViewController {
      return aboutUsViewController
    } else if viewController == aboutUsViewController {
      return nil
    } else {
      return nil
    }
  }
}

// MARK: Delegate
extension MainPageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    // swiftlint:disable unused_optional_binding
    if completed {
      if let _ = previousViewControllers.first as? VenuesViewController {
        swipeDelegate?.didSwipeTo(self, choice: .aboutUs)
      } else if let _ = previousViewControllers.first as? AboutUsViewController {
        swipeDelegate?.didSwipeTo(self, choice: .venues)
      }
    }
  }
}
