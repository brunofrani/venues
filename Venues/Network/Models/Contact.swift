//
//  Contact.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//  Contact.swift
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Contact: Codable, Hashable {

  let facebook: String?
  let facebookName: String?
  let facebookUsername: String?
  let formattedPhone: String?
  let phone: String?
  let twitter: String?

  enum CodingKeys: String, CodingKey {
    case facebook
    case facebookName
    case facebookUsername
    case formattedPhone
    case phone
    case twitter
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
    facebookName = try values.decodeIfPresent(String.self, forKey: .facebookName)
    facebookUsername = try values.decodeIfPresent(String.self, forKey: .facebookUsername)
    formattedPhone = try values.decodeIfPresent(String.self, forKey: .formattedPhone)
    phone = try values.decodeIfPresent(String.self, forKey: .phone)
    twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
  }

}
