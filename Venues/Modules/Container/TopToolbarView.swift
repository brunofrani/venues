//
//  TopToolbarView.swift
//  Venues
//
//  Created by Bruno Frani on 30.3.22.
//

import UIKit

enum SegmentedChoice {
  case venues
  case aboutUs
}

protocol TopToolbarViewDelegate: AnyObject {
  func didSelectIndex(_ view: TopToolbarView, choice: SegmentedChoice)
}

class TopToolbarView: UIView {

  weak var delegate: TopToolbarViewDelegate?

  private lazy var segmentedControl: UISegmentedControl = {
  let control = UISegmentedControl()
    control.translatesAutoresizingMaskIntoConstraints = false
    control.insertSegment(withTitle: "Venue", at: 0, animated: false)
    control.insertSegment(withTitle: "About Us", at: 1, animated: false)
    control.selectedSegmentIndex = 0
    control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    return control
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewsAndConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViewsAndConstraints() {

    addSubview(segmentedControl)

    segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  }

  func switchSelectedIndex(_ choice: SegmentedChoice) {
    switch choice {
    case .venues:
      segmentedControl.selectedSegmentIndex = 0
    case .aboutUs:
      segmentedControl.selectedSegmentIndex = 1
    }
  }

  @objc func segmentChanged() {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
      delegate?.didSelectIndex(self, choice: .venues)
    case 1:
      delegate?.didSelectIndex(self, choice: .aboutUs)
    default:
      break
    }
  }
}
