//
//  LocationManager.swift
//  Venues
//
//  Created by Bruno Frani on 2.4.22.
//

import CoreLocation
import Foundation

public struct LocationData {
  let latitude: Double
  let longitude: Double
}

enum LocationPermisionStatus {
  case notDetermined
  case whenInUse
  case denied
  case restricted
  case disabled
  case unknown
}

public class LocationManager: NSObject {
  private var locationRetrieved: ((Result<LocationData, Error>) -> Void)?
  private var statusChanged: ((Result<LocationPermisionStatus, Error>) -> Void)?
  private let locationManager = CLLocationManager()

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  var status: LocationPermisionStatus {
    return convertStatus(status: locationManager.authorizationStatus)
  }

  func requestAuthorization(completionHandler : @escaping (Result<LocationPermisionStatus, Error>) -> Void) {
    guard status == .notDetermined else { return }

    locationManager.requestWhenInUseAuthorization()
    statusChanged = completionHandler
  }

  func requestLocation(completionHandler : @escaping (Result<LocationData, Error>) -> Void) {
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    locationRetrieved = completionHandler
  }

  func convertStatus(status: CLAuthorizationStatus) -> LocationPermisionStatus {
    guard CLLocationManager.locationServicesEnabled() else { return .disabled }

    switch status {
    case .notDetermined:
      return .notDetermined
    case .restricted:
      return .restricted
    case .denied:
      return .denied
    // this case will not be trigged anytime beacuse we ask for onlyInUse permission
    case .authorizedAlways:
      return .whenInUse
    case .authorizedWhenInUse:
      return .whenInUse
    @unknown default:
      return .unknown
    }
  }

}

extension LocationManager: CLLocationManagerDelegate {

  public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if let statuschanged = statusChanged {
      statuschanged(.success(convertStatus(status: status)))
    }
  }

  // the callback after calling "request Location"
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    locationManager.stopUpdatingLocation()
    // fix cause the delegate gets called multiple times
    locationManager.delegate = nil
    if let location = locations.first {
      guard location.horizontalAccuracy > 0 else { return }

      let longitude = location.coordinate.longitude
      let latitude = location.coordinate.latitude
      if let locationretreived = locationRetrieved {
        locationretreived(.success(LocationData(latitude: latitude, longitude: longitude)))
      }
    }
  }

  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if let locationretreived = locationRetrieved {
      locationretreived(.failure(error))
    }
  }
}
