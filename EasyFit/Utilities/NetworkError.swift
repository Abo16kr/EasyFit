//
//  NetworkError.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 21.03.2024.
//

import Foundation


enum NetworkError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case serverError // 500-599
    case unknown
    case nonHTTPResponse
    case decodingError(Error)
    case other(Error)

}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "🔥The request was invalid or cannot be served. Please modify your request."
        case .unauthorized:
            return "🔥Authentication is required and has failed or has not been provided."
        case .forbidden:
            return "🔥You do not have the necessary permissions to access this resource."
        case .notFound:
            return "🔥The requested resource could not be found but may be available again in the future."
        case .serverError:
            return "🗄️An error occurred on the server side. Please try again later."
        case .unknown:
            return "🔥An unknown error occurred."
        case .nonHTTPResponse:
            return "🔥Received a non-HTTP response."
        case .decodingError(let error):
            return "🔥Failed to decode the response: \(error.localizedDescription)"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
