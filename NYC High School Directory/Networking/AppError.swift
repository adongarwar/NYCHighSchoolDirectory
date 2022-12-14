//
//  AppError.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

public enum AppError: Error, CustomStringConvertible {
	case keyMappingFailure(message: String?)
	case noInternet
	case timedOut
	case networkError(Error)
	case invalidEndpoint(String)
	case unknown(Error)
	
	public var description: String {
		switch self {
			case .keyMappingFailure(let message):
				return "Json decoding error - \(String(describing: message)))"
			case .noInternet:
				return "No internet connection"
			case .timedOut:
				return "Connection timed out"
			case .networkError(let code):
				return "Network error with code \(code)"
			case .unknown(let error):
				return "Unknown error - \(error.localizedDescription)"
			case .invalidEndpoint(let urlString):
				return "Invalid endpint - \(urlString)"
		}
	}
}

extension Error {
	var appError: AppError {
		if let decoderError = self as? DecodingError {
			switch decoderError {
				case .typeMismatch(_, let c), .valueNotFound(_, let c),
						.keyNotFound(_, let c), .dataCorrupted(let c):
					return .keyMappingFailure(message: c.debugDescription)
				default:
					return .unknown(self)
			}
		} else if (self as? URLError)?.code == URLError.Code.notConnectedToInternet {
			return .noInternet
		} else if (self as? URLError)?.code ==  URLError.Code.timedOut {
			return .timedOut
		} else if self is URLError {
			return .networkError(self)
		} else {
			return .unknown(self)
		}
	}
}
