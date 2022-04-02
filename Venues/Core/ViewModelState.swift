//
//  ViewModelState.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation

enum ViewModelState {
  case initial
  case loading
  case data(value: Any)
  case empty
  case error(value: Error)
}
