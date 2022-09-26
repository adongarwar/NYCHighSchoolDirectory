//
//  NetworkManager.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

extension URLSession {
	
	func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, AppError>) -> Void) {
		
		guard let url = URL(string: urlString) else {
			completion(.failure(AppError.invalidEndpoint(urlString)))
			return
		}
		
		self.dataTask(with: url) { (data, response, error) in
			if let error = error {
				completion(.failure(error.appError))
			}
			if let data = data {
				do {
					let object = try JSONDecoder().decode(T.self, from: data)
					completion(.success(object))
				} catch let decoderError {
					completion(.failure(decoderError.appError))
				}
			}
		}.resume()
	}
}
