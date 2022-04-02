//
//  AboutUsViewController.swift
//  Venues
//
//  Created by Bruno Frani on 30.3.22.
//

import UIKit

class AboutUsViewController: UIViewController {

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .natural
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviewsAndConstraints()
    // swiftlint:disable line_length
    descriptionLabel.text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ac enim convallis, congue purus id, porttitor leo. Phasellus ullamcorper mi sit amet turpis molestie, dapibus consequat lorem suscipit. Maecenas justo tortor, maximus sit amet hendrerit vel, fringilla eget ipsum. Donec placerat volutpat scelerisque. Etiam mi sapien, ultricies non sagittis vel, posuere quis est. Nullam tristique nisi lacus, fermentum placerat metus scelerisque a. Suspendisse nibh purus, mollis sed tortor eu, pulvinar scelerisque mauris. Praesent vitae nunc sagittis, tristique diam nec, fermentum ligula. Nam luctus, elit a pretium ullamcorper, sem risus tempor neque, quis semper sapien turpis ac massa. In eu lacus facilisis, facilisis nisi sit amet, elementum arcu. Etiam euismod magna quis enim rhoncus, et lobortis justo mollis.

"""
    // swiftlint:enable: line_length
  }

  private func setupSubviewsAndConstraints() {
    view.backgroundColor = .white
    view.addSubview(descriptionLabel)

    descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
  }
}
