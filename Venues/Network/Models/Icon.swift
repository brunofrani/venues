//
//  Icon.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Icon: Codable, Hashable {

  let mapPrefix: String?
  let prefix: String?
  let suffix: String?

  enum CodingKeys: String, CodingKey {
    case mapPrefix
    case prefix
    case suffix
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    mapPrefix = try values.decodeIfPresent(String.self, forKey: .mapPrefix)
    prefix = try values.decodeIfPresent(String.self, forKey: .prefix)
    suffix = try values.decodeIfPresent(String.self, forKey: .suffix)
  }

}
