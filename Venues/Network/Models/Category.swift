//
//  Category.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.

import Foundation
// swiftlint:disable identifier_name
struct Category: Codable, Hashable {

  let icon: Icon?
  let id: String?
  let name: String?
  let pluralName: String?
  let primary: Bool?
  let shortName: String?

  enum CodingKeys: String, CodingKey {
    case icon
    case id
    case name
    case pluralName
    case primary
    case shortName
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    icon = try Icon(from: decoder)
    id = try values.decodeIfPresent(String.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    pluralName = try values.decodeIfPresent(String.self, forKey: .pluralName)
    primary = try values.decodeIfPresent(Bool.self, forKey: .primary)
    shortName = try values.decodeIfPresent(String.self, forKey: .shortName)
  }

}
