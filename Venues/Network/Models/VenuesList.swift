//
//  VenuesList.swift
//  Venues
//
//  Created by Bruno Frani on 28.3.22.
//
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct VenuesList: Codable, Hashable {

  let meta: Meta?
  let notifications: [Notification]?
  let response: Response?

  enum CodingKeys: String, CodingKey {
    case meta
    case notifications
    case response
  }

}
