//
//  TestSchoolListViewModel.swift
//  NYC High School DirectoryTests
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

class TestSchoolsListViewDelegate: SchoolsListViewDelegate {
	
	var dataFetched: ((_ newIndexPathsToReload: [IndexPath]) -> Void)?
	var handleError: ((_ error: AppError) -> Void)?
	
	func schoolListUpdated(with newIndexPathsToReload: [IndexPath]) {
		dataFetched?(newIndexPathsToReload)
	}
	
	func handle(error: AppError) {
		handleError?(error)
	}
}
