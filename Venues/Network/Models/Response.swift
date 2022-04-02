//
//  Response.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Response: Codable, Hashable {

  let confident: Bool?
  let venues: [Venue]?

  enum CodingKeys: String, CodingKey {
    case confident
    case venues
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    confident = try values.decodeIfPresent(Bool.self, forKey: .confident)
    venues = try values.decodeIfPresent([Venue].self, forKey: .venues)
  }

}
