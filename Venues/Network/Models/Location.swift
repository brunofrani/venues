//
//  Location.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//

// swiftlint:disable identifier_name
import Foundation

struct Location: Codable, Hashable {

  let address: String?
  let cc: String?
  let city: String?
  let contextGeoId: Int?
  let contextLine: String?
  let country: String?
  let crossStreet: String?
  let distance: Int?
  let formattedAddress: [String]?
  let labeledLatLngs: [LabeledLatLng]?
  let lat: Float?
  let lng: Float?
  let postalCode: String?
  let state: String?

  enum CodingKeys: String, CodingKey {
    case address
    case cc
    case city
    case contextGeoId
    case contextLine
    case country
    case crossStreet
    case distance
    case formattedAddress
    case labeledLatLngs
    case lat
    case lng
    case postalCode
    case state
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    address = try values.decodeIfPresent(String.self, forKey: .address)
    cc = try values.decodeIfPresent(String.self, forKey: .cc)
    city = try values.decodeIfPresent(String.self, forKey: .city)
    contextGeoId = try values.decodeIfPresent(Int.self, forKey: .contextGeoId)
    contextLine = try values.decodeIfPresent(String.self, forKey: .contextLine)
    country = try values.decodeIfPresent(String.self, forKey: .country)
    crossStreet = try values.decodeIfPresent(String.self, forKey: .crossStreet)
    distance = try values.decodeIfPresent(Int.self, forKey: .distance)
    formattedAddress = try values.decodeIfPresent([String].self, forKey: .formattedAddress)
    labeledLatLngs = try values.decodeIfPresent([LabeledLatLng].self, forKey: .labeledLatLngs)
    lat = try values.decodeIfPresent(Float.self, forKey: .lat)
    lng = try values.decodeIfPresent(Float.self, forKey: .lng)
    postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
    state = try values.decodeIfPresent(String.self, forKey: .state)
  }

}
