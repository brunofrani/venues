//
//  VenuePage.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//

import Foundation

// swiftlint:disable identifier_name
struct VenuePage: Codable, Hashable {

  let id: String?

  enum CodingKeys: String, CodingKey {
    case id
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(String.self, forKey: .id)
  }

}
