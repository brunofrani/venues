//
//  Request.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation

public protocol WRequest {
    associatedtype ReturnType: Codable
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: HTTPContentType { get }
    var queryParams: HTTPParams? { get }
    var body: HTTPParams? { get }
    var headers: HTTPHeaders? { get }
    var decoder: JSONDecoder? { get }
}

public extension WRequest {

    // Defaults
    var method: HTTPMethod { return .get }
    var contentType: HTTPContentType { return .json }
    var queryParams: HTTPParams? { return nil }
    var body: HTTPParams? { return nil }
    var headers: HTTPHeaders? { return nil }
    var debug: Bool { return false }
    var decoder: JSONDecoder? { return JSONDecoder() }

}

// Utility Methods
extension WRequest {

    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: HTTPParams?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }

    /// Generates a URLQueryItems array from a Params dictionary
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: An Array of URLQueryItems
    private func queryItemsFrom(params: HTTPParams?) -> [URLQueryItem]? {
        guard let params = params else { return nil }
        return params.map {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
    }

    /// Transforms an WKRequest into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = queryItemsFrom(params: queryParams)
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        let defaultHeaders: HTTPHeaders = [
            HTTPHeaderField.contentType.rawValue: contentType.rawValue,
            HTTPHeaderField.acceptType.rawValue: contentType.rawValue
        ]
        request.allHTTPHeaderFields = defaultHeaders.merging(headers ?? [:], uniquingKeysWith: { (first, _) in first })
        return request
    }

}
