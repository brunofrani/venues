//
//  Special.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Special: Codable, Hashable {

  let count: Int?
  let items: [String]?

  enum CodingKeys: String, CodingKey {
    case count
    case items
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    count = try values.decodeIfPresent(Int.self, forKey: .count)
    items = try values.decodeIfPresent([String].self, forKey: .items)
  }

}
