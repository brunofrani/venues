//
//  VenueEndpoint.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation

struct VenueEndpoint: WRequest {

  typealias ReturnType = VenuesList
  var path: String = "/venues/search"
  var queryParams: HTTPParams?

  init(queryParams: HTTPParams? = nil) {
    self.queryParams = queryParams
  }
}
