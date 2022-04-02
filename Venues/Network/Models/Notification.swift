//
//  Notification.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Notification: Codable, Hashable {

  let item: Item?
  let type: String?

  enum CodingKeys: String, CodingKey {
    case item
    case type
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    item = try Item(from: decoder)
    type = try values.decodeIfPresent(String.self, forKey: .type)
  }

}
