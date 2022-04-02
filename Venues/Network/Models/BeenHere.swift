//
//  BeenHere.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.

//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct BeenHere: Codable, Hashable {

  let lastCheckinExpiredAt: Int?

  enum CodingKeys: String, CodingKey {
    case lastCheckinExpiredAt
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    lastCheckinExpiredAt = try values.decodeIfPresent(Int.self, forKey: .lastCheckinExpiredAt)
  }

}
