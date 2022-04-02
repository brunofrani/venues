//
//  VenueModel.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//

import Foundation

// swiftlint:disable identifier_name
struct Venue {

  let allowMenuUrlEdit: Bool?
  let beenHere: BeenHere?
  let canonicalName: String?
  let canonicalPath: String?
  let canonicalUrl: String?
  let categories: [Category]?
  let contact: Contact?
  let hasPerk: Bool?
  let hereNow: HereNow?
  let id: String?
  let location: Location?
  let locked: Bool?
  let name: String?
  let referralId: String?
  let specials: Special?
  let stats: Stat?
  let storeId: String?
  let url: String?
  let urlSig: String?
  let venuePage: VenuePage?
  let verified: Bool?
}

extension Venue: Codable, Hashable {
  enum CodingKeys: String, CodingKey {
    case allowMenuUrlEdit
    case beenHere
    case canonicalName
    case canonicalPath
    case canonicalUrl
    case categories
    case contact
    case hasPerk
    case hereNow
    case id
    case location
    case locked
    case name
    case referralId
    case specials
    case stats
    case storeId
    case url
    case urlSig
    case venuePage
    case verified
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    allowMenuUrlEdit = try values.decodeIfPresent(Bool.self, forKey: .allowMenuUrlEdit)
    beenHere = try BeenHere(from: decoder)
    canonicalName = try values.decodeIfPresent(String.self, forKey: .canonicalName)
    canonicalPath = try values.decodeIfPresent(String.self, forKey: .canonicalPath)
    canonicalUrl = try values.decodeIfPresent(String.self, forKey: .canonicalUrl)
    categories = try values.decodeIfPresent([Category].self, forKey: .categories)
    contact = try Contact(from: decoder)
    hasPerk = try values.decodeIfPresent(Bool.self, forKey: .hasPerk)
    hereNow = try HereNow(from: decoder)
    id = try values.decodeIfPresent(String.self, forKey: .id)
    location = try Location(from: decoder)
    locked = try values.decodeIfPresent(Bool.self, forKey: .locked)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    referralId = try values.decodeIfPresent(String.self, forKey: .referralId)
    specials = try Special(from: decoder)
    stats = try Stat(from: decoder)
    storeId = try values.decodeIfPresent(String.self, forKey: .storeId)
    url = try values.decodeIfPresent(String.self, forKey: .url)
    urlSig = try values.decodeIfPresent(String.self, forKey: .urlSig)
    venuePage = try VenuePage(from: decoder)
    verified = try values.decodeIfPresent(Bool.self, forKey: .verified)
  }

}
