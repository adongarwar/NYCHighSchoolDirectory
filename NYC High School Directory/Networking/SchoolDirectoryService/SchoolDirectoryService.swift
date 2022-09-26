//
//  SchoolDirectoryService.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

enum APIResource {
	case directory(Int, Int)
	case satResults(String)
	
	var resourceId: String {
		switch self {
			case .directory:
				return "s3k6-pzi2"
			case .satResults:
				return "f9bf-2cp4"
		}
	}
	
	var baseUrlString: String {
		return "https://data.cityofnewyork.us/resource/\(resourceId).json"
	}
	
	var urlWithQueriesString: String {
		switch self {
			case .directory(let limit, let offset):
				return baseUrlString + "?" + "$limit=\(limit)&$offset=\(offset)"
			case .satResults(let schoolId):
				return baseUrlString + "?" + "dbn=\(schoolId)"
		}
		
	}
}

protocol SchoolDirectoryService {
	func fetchSchools(_ limit: Int, _ offset: Int,
					  _ completion: @escaping (Result<[School], AppError>) -> Void)
	func fetchSATResults(_ schoolId: String,
						 _ completion: @escaping (Result<[SATResult], AppError>) -> Void)
}

struct SchoolsDataService: SchoolDirectoryService {
	let session = URLSession.shared
	
	func fetchSchools(_ limit: Int, _ offset: Int,
					  _ completion: @escaping (Result<[School], AppError>) -> Void) {
		let urlString = APIResource.directory(limit, offset).urlWithQueriesString
		session.fetchData(urlString: urlString) { (results: (Result<[School], AppError>)) in
			switch results {
				case .success(let results):
					completion(.success(results))
					
				case .failure(let error):
					completion(.failure(error))
			}
		}
	}
	
	func fetchSATResults(_ schoolId: String,
						 _ completion: @escaping (Result<[SATResult], AppError>) -> Void) {
		let urlString = APIResource.satResults(schoolId).urlWithQueriesString
		session.fetchData(urlString: urlString) { (results: (Result<[SATResult], AppError>)) in
			switch results {
				case .success(let results):
					completion(.success(results))
					
				case .failure(let error):
					completion(.failure(error))
			}
		}
	}
}
