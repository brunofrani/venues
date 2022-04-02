//
//  Item.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Item: Codable, Hashable {

  let unreadCount: Int?

  enum CodingKeys: String, CodingKey {
    case unreadCount
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    unreadCount = try values.decodeIfPresent(Int.self, forKey: .unreadCount)
  }

}
