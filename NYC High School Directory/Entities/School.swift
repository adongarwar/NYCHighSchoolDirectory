//
//  School.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

struct School: Decodable {
	
	let schoolId: String
	let name: String
	
	private enum CodingKeys: String, CodingKey {
		case schoolId = "dbn"
		case name = "school_name"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		schoolId = try container.decode(String.self, forKey: .schoolId)
		name = try container.decode(String.self, forKey: .name)
	}
	
	init(schoolId: String, name: String) {
		self.schoolId = schoolId
		self.name = name
	}
}
