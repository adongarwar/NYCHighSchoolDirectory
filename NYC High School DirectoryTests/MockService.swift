//
//  MockService.swift
//  NYC High School DirectoryTests
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

class MockService: SchoolDirectoryService {
	
	var schools: [School]?
	var error: AppError?
	
	
	func fetchSchools(_ limit: Int, _ offset: Int,
					  _ completion: @escaping (Result<[School], AppError>) -> Void) {
		DispatchQueue.main.async {
			guard let schools = self.schools else {
				completion(.failure(self.error!))
				return
			}
			completion(.success(schools))
		}
		
		
	}
	
	func fetchSATResults(_ schoolId: String,
						 _ completion: @escaping (Result<[SATResult], AppError>) -> Void) {
		
		
	}
}
