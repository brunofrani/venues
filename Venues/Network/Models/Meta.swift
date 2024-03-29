//
//  Meta.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Meta: Codable, Hashable {

  let code: Int?
  let requestId: String?

  enum CodingKeys: String, CodingKey {
    case code
    case requestId
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    code = try values.decodeIfPresent(Int.self, forKey: .code)
    requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
  }

}
