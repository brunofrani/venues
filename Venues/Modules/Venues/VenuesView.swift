//
//  VenuesView.swift
//  Venues
//
//  Created by Bruno Frani on 30.3.22.
//

import UIKit

class VenuesView: UIView {

  lazy var collectionView: UICollectionView = {
    let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    let layout = UICollectionViewCompositionalLayout.list(using: config)

    let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return collectionView
  }()

  lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, VenueInfo> = {
    // Configures the collection view cell
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, VenueInfo> { cell, _, venue in
      var content = cell.defaultContentConfiguration()
      content.text = venue.name
      cell.contentConfiguration = content
    }// swiftlint:disable line_length
    let dataSource = UICollectionViewDiffableDataSource<Int, VenueInfo>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
      return cell
    }// swiftlint:enable line_length
    return dataSource
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviewsAndConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupSubviewsAndConstraints() {
    backgroundColor = .green
    addSubview(collectionView)
  }

}
