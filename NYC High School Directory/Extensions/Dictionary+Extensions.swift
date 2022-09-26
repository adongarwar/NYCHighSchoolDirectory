//
//  Dictionary+Extensions.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

extension Dictionary {
	subscript(i: Int) -> (key: Key, value: Value) {
		return self[index(startIndex, offsetBy: i)]
	}
}
