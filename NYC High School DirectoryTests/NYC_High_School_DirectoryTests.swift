//
//  NYC_High_School_DirectoryTests.swift
//  NYC High School DirectoryTests
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import XCTest
@testable import NYC_High_School_Directory

class NYC_High_School_DirectoryTests: XCTestCase {
	
	var viewModel: SchoolsListViewModel!
	var mockService: MockService!
	var responseMonitor: TestSchoolsListViewDelegate!
	
	override func setUp() {
		super.setUp()
		viewModel = SchoolsListViewModel()
		
		mockService = MockService()
		responseMonitor = TestSchoolsListViewDelegate()
		viewModel.schoolsDataService = mockService
		viewModel.delegate = responseMonitor
	}
	
	override func tearDown() {
		super.tearDown()
		mockService = nil
		viewModel = nil
		responseMonitor = nil
	}
	
	func testSchoolsListInitialLoad() throws {
		
		let schoolsListLoadedExpectation = expectation(description: "Schools are available")
		
		responseMonitor.dataFetched = { newIndexPaths in
			XCTAssertTrue(newIndexPaths.count == 0, "Indexpaths return blank for initial load.")
			schoolsListLoadedExpectation.fulfill()
		}
		
			// simulating the enviornment
		mockService.error = nil
		mockService.schools = [School(schoolId: "School1", name: "School 1"),
							   School(schoolId: "School2", name: "School 2"),
							   School(schoolId: "School3", name: "School 3"),
							   School(schoolId: "School4", name: "School 4"),
							   School(schoolId: "School5", name: "School 5")]
		
		
		viewModel.fetchSchoolList()
		
		wait(for: [schoolsListLoadedExpectation], timeout: 10.0)
	}
}
