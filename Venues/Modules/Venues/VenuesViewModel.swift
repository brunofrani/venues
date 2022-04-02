//
//  VenuesViewModel.swift
//  Venues
//
//  Created by Bruno Frani on 30.3.22.
//

import UIKit
import Combine
import CoreData

final class VenuesViewModel: NSObject {

  private let dependecies: AppDependencies
  private var cancellables = [AnyCancellable]()
  @Published var state: ViewModelState = .initial

  fileprivate lazy var fetchedResultsController: NSFetchedResultsController<ManagedVenue> = {
    let fetchRequest = ManagedVenue.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    let fetchedResultsController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: dependecies.persistenceService.persistentContainer.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil)
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()

  init(dependencies: AppDependencies) {
    self.dependecies = dependencies
  }

  func getStoredVenues() {
    state = .loading
    do {
      try fetchedResultsController.performFetch()
    } catch  let error {
      state = .error(value: error)
    }
  }

  func requestLocationPermissionAthorization() {

    if dependecies.locationManager.status == .notDetermined {
      dependecies.locationManager.requestAuthorization { [ weak self ] result in
        switch result {

        case .success(let status):
          switch status {
          case .notDetermined, .denied, .disabled, .restricted, .unknown:
            self?.state = .error(value: AppError(title: "Location Error", description: "Location permission denied"))

          case .whenInUse:
            self?.getCurrentLocation()
          }

        case .failure(let error):
          self?.state = .error(value: error)
        }
      }
    } else if dependecies.locationManager.status == .whenInUse {

      getCurrentLocation()
    } else {
      // swiftlint:disable line_length
      state = .error(value: AppError(title: "Location Error", description: "The application has no permission to access location"))
    }
  }

 private func getCurrentLocation() {
    dependecies.locationManager.requestLocation { [ weak self] result in
      switch result {
      case .success(let location):
        self?.getVenues(location: location)
      case .failure(let error):
        self?.state = .error(value: error)
      }
    }
  }

 private func getVenues(location: LocationData) {
    let queryParams = ["client_id": NetworkConstants.clientID,
                       "client_secret": NetworkConstants.clientSecret,
                       "v": NetworkConstants.apiVersion,
                       "ll": "\(location.latitude), \(location.longitude)"
    ]

    let getVenues = VenueEndpoint(queryParams: queryParams)
    dependecies.networkClient.dispatch(getVenues)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] result in
          switch result {
          case .failure(let error):

            // MARK: used to continue the flow with local data
//            do {
//            let url = Bundle.main.url(forResource: "VenuesList", withExtension: "json")
//            let data = try Data(contentsOf: url!)
//            let decoded =  try JSONDecoder().decode(VenuesList.self, from: data)
//              self?.saveVenueList(decoded)
//            } catch (let error){
//              print(error)
//              self?.state = .error(value: error)
//            }
            self?.state = .error(value: error)
          default: break
          }
        },
        receiveValue: { [weak self] value in
          self?.saveVenueList(value)
        })
      .store(in: &cancellables)
  }

  private func saveVenueList(_ venuesList: VenuesList) {
    do {
      try dependecies.persistenceService.saveVenuesList(venuesList)
    } catch let error {
      state = .error(value: error)
    }
  }
}

// MARK: Fetched results controller delegate
extension VenuesViewModel: NSFetchedResultsControllerDelegate {

  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {

    let snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>

    let managedVenues: [ManagedVenue] =  snapshot.itemIdentifiers.compactMap { objectID in
      guard let managedVenues = try? dependecies.persistenceService.persistentContainer.viewContext.existingObject(with: objectID) as? ManagedVenue else {
        return nil
      }
      return managedVenues
    }

    let venues = managedVenues.map {
      VenueInfo(name: $0.name, id: $0.id)
    }
    state = .data(value: venues)
  }
}
