//
//  SchoolsListViewModel.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation
import Network

protocol SchoolsListViewDelegate: AnyObject {
	func schoolListUpdated(with newIndexPathsToReload: [IndexPath])
	func handle(error: AppError)
}

class SchoolsListViewModel {
	
	weak var delegate: SchoolsListViewDelegate?
	private(set) var schoolCellModels = [SchoolCellModel]()
	private var schools = [School]() {
		didSet {
			schoolCellModels = schools.compactMap({
				SchoolCellModel(from: $0)
			})
		}
	}
	var schoolsDataService: SchoolDirectoryService = SchoolsDataService()
	private let limit = 10
	private var offset = 0
	private(set) var isFetchInProgress = false
	
	var currentCount: Int {
		return schools.count
	}
	
	func fetchSchoolList() {
		guard !isFetchInProgress else {
			return
		}
		
		isFetchInProgress = true
		offset = currentCount == 0 ? offset : offset + limit
		schoolsDataService.fetchSchools(limit, offset) { [weak self] results in
			guard let strongself = self else { return }
			switch results {
				case .success(let results):
					strongself.handleSuccess(newSchools: results)
				case .failure(let error):
					strongself.handleError(error: error)
			}
		}
	}
	
	private func handleSuccess(newSchools: [School]) {
		isFetchInProgress = false
		schools.append(contentsOf: newSchools)
		delegate?.schoolListUpdated(with: indexPathsToReload(from: newSchools))
	}
	
	private func handleError(error: AppError) {
		isFetchInProgress = false
			//Reset for failure
		offset = currentCount == 0 ? 0 : offset - limit
		delegate?.handle(error: error)
	}
	
	private func indexPathsToReload(from newSchools: [School]) -> [IndexPath] {
		guard currentCount - newSchools.count > 0 else {
			return []
		}
		let startIndex = currentCount - newSchools.count
		let endIndex = startIndex + newSchools.count
		return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
	}
}

