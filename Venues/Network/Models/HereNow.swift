//
//  HereNow.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HereNow: Codable, Hashable {

  let count: Int?
  let groups: [String]?
  let summary: String?

  enum CodingKeys: String, CodingKey {
    case count
    case groups
    case summary
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    count = try values.decodeIfPresent(Int.self, forKey: .count)
    groups = try values.decodeIfPresent([String].self, forKey: .groups)
    summary = try values.decodeIfPresent(String.self, forKey: .summary)
  }

}
