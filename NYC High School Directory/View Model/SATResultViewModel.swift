//
//  SATResultViewModel.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation
import Network

protocol SATResultViewDelegate: AnyObject {
	func satResultFetched()
	func handle(error: AppError)
}

class SATResultViewModel {
	
	weak var delegate: SATResultViewDelegate?
	private var schoolsDataService: SchoolDirectoryService = SchoolsDataService()
	private(set) var dataDictionary = [String: (value: String, displayIndex: Int)]()
	
	func fetchSATResults(schoolId: String) {
		schoolsDataService.fetchSATResults(schoolId, { [weak self] results in
			guard let strongself = self else { return }
			switch results {
				case .success(let result):
					strongself.populateDictionary(with: result)
					strongself.delegate?.satResultFetched()
				case .failure(let error):
					strongself.delegate?.handle(error: error)
			}
		})
	}
	
	func populateDictionary(with satResults: [SATResult]) {
		guard satResults.count > 0 else {
			return
		}
		let satResult = satResults.first!
		dataDictionary["School Name".localizedString] = (satResult.name, 0)
		dataDictionary["Total Candidates".localizedString] = (satResult.numberOfTestTakers, 1)
		dataDictionary["Reading Score".localizedString] = (satResult.readingScore, 2)
		dataDictionary["Math Scores".localizedString] = (satResult.mathScore, 3)
		dataDictionary["Writing Scores".localizedString] = (satResult.writingScore, 4)
	}
}
