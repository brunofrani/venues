//
//  Encodable+Extension.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation

// Extending Encodable to Serialize a Type into a Dictionary
extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
      // swiftlint:disable line_length
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
