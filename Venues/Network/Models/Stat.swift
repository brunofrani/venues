//
//  Stat.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Stat: Codable, Hashable {

  let checkinsCount: Int?
  let tipCount: Int?
  let usersCount: Int?

  enum CodingKeys: String, CodingKey {
    case checkinsCount
    case tipCount
    case usersCount
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    checkinsCount = try values.decodeIfPresent(Int.self, forKey: .checkinsCount)
    tipCount = try values.decodeIfPresent(Int.self, forKey: .tipCount)
    usersCount = try values.decodeIfPresent(Int.self, forKey: .usersCount)
  }

}
