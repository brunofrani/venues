//
//  NetworkClient.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation
import Combine

public struct APIClient {

  public var baseURL: String!
  public var networkDispatcher: NetworkDispatcher!

  public init(baseURL: String,
              networkDispatcher: NetworkDispatcher = NetworkDispatcher()) {
    self.baseURL = baseURL
    self.networkDispatcher = networkDispatcher
  }

  /// Dispatches an WKRequest and returns a publisher
  /// - Parameter request: WKRequest to Dispatch
  /// - Returns: A publisher containing decoded data or an error
  public func dispatch<Request: WRequest>(_ request: Request) -> AnyPublisher<Request.ReturnType, NetworkRequestError> {
    guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
      return Fail(outputType: Request.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
    }

    typealias RequestPublisher = AnyPublisher<Request.ReturnType, NetworkRequestError>
    let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest, decoder: request.decoder)
    return requestPublisher.eraseToAnyPublisher()
  }
}
