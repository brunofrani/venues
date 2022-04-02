//
//  LabeledLatLng.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct LabeledLatLng: Codable, Hashable {

  let label: String?
  let lat: Float?
  let lng: Float?

  enum CodingKeys: String, CodingKey {
    case label
    case lat
    case lng
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    label = try values.decodeIfPresent(String.self, forKey: .label)
    lat = try values.decodeIfPresent(Float.self, forKey: .lat)
    lng = try values.decodeIfPresent(Float.self, forKey: .lng)
  }

}
