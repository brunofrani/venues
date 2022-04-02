//
//  AppDependencies.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation

protocol HasNetworkCient {
  var networkClient: APIClient { get set }
}

protocol HasPersistentService {
  var persistenceService: PersistenceService { get set }
}

protocol HasLocationService {
  var locationManager: LocationManager { get set }
}
struct AppDependencies: HasNetworkCient & HasPersistentService & HasLocationService {
  var networkClient: APIClient
  var persistenceService: PersistenceService
  var locationManager: LocationManager
}
