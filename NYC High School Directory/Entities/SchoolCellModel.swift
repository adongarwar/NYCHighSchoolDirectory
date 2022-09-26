//
//  SchoolCellModel.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

struct SchoolCellModel {
	
	let schoolId: String
	let name: String
	
	init(from school: School) {
		self.schoolId = school.schoolId
		self.name = school.name
	}
}
