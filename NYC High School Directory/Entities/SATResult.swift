//
//  SATResult.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

struct SATResult: Decodable {
	
	let schoolId: String
	let name: String
	let numberOfTestTakers: String
	let readingScore: String
	let mathScore: String
	let writingScore: String
	
	private enum CodingKeys: String, CodingKey {
		case schoolId = "dbn"
		case name = "school_name"
		case numberOfTestTakers = "num_of_sat_test_takers"
		case readingScore = "sat_critical_reading_avg_score"
		case mathScore = "sat_math_avg_score"
		case writingScore = "sat_writing_avg_score"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		schoolId = try container.decode(String.self, forKey: .schoolId)
		name = try container.decode(String.self, forKey: .name)
		numberOfTestTakers = try container.decode(String.self, forKey: .numberOfTestTakers)
		readingScore = try container.decode(String.self, forKey: .readingScore)
		mathScore = try container.decode(String.self, forKey: .mathScore)
		writingScore = try container.decode(String.self, forKey: .writingScore)
	}
}
