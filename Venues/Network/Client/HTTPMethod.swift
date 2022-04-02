//
//  HTTPMethod.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation

public typealias HTTPParams = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPContentType: String {
    case json = "application/json"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}
