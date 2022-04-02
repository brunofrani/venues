//
//  NetworkDispatcher.swift
//  Venues
//
//  Created by Bruno Frani on 1.4.22.
//

import Foundation
import Combine

public struct NetworkDispatcher {

  let urlSession: URLSession!

  public init(urlSession: URLSession = .shared) {
    self.urlSession = urlSession
  }

  /// Dispatches an URLRequest and returns a publisher
  /// - Parameter request: URLRequest
  /// - Returns: A publisher with the provided decoded data or an error
  // swiftlint:disable:next line_length
  public func dispatch<ReturnType: Codable>(request: URLRequest, decoder: JSONDecoder?) -> AnyPublisher<ReturnType, NetworkRequestError> {

    let decoder = decoder ?? JSONDecoder()

    return urlSession
      .dataTaskPublisher(for: request)
      .tryMap({ data, response in
        if let response = response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
          throw httpError(response.statusCode)
        }
        return data
      })
      .decode(type: ReturnType.self, decoder: decoder)
      .mapError { error in
        handleError(error)
      }
      .eraseToAnyPublisher()
  }

  /// Parses a HTTP StatusCode and returns a proper error
  /// - Parameter statusCode: HTTP status code
  /// - Returns: Mapped Error
  private func httpError(_ statusCode: Int) -> NetworkRequestError {
    switch statusCode {
    case 400: return .badRequest
    case 401: return .unauthorized
    case 403: return .forbidden
    case 404: return .notFound
    case 402, 405...499: return .error4xx(statusCode)
    case 500: return .serverError
    case 501...599: return .error5xx(statusCode)
    default: return .unknownError
    }
  }

  /// Parses URLSession Publisher errors and return proper ones
  /// - Parameter error: URLSession publisher error
  /// - Returns: Readable NWKNetworkRequestError
  private func handleError(_ error: Error) -> NetworkRequestError {
    print(error)
    switch error {
    case is Swift.DecodingError:
      return .decodingError
    case let urlError as URLError:
      return .urlSessionFailed(urlError)
    case let error as NetworkRequestError:
      return error
    default:
      return .unknownError
    }
  }

  private func debugMessage(_ message: String) {
#if DEBUG
    print("--- WK Request \(message)")
#endif
  }

}
