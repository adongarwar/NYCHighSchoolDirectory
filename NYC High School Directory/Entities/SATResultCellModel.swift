//
//  SATResultCellModel.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

struct SATResultCellModel {
	
	let schoolId: String
	let name: String
	let numberOfTestTakers: String
	let readingScore: String
	let mathScore: String
	let writingScore: String
	
	init(from result: SATResult) {
		self.schoolId = result.schoolId
		self.name = result.name
		self.numberOfTestTakers = result.numberOfTestTakers
		self.readingScore = result.readingScore
		self.mathScore = result.mathScore
		self.writingScore = result.writingScore
	}
}
