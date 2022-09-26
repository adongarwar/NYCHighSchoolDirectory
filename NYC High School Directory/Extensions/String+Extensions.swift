//
//  String+Extensions.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import Foundation

extension String {
	var localizedString: String {
		return NSLocalizedString(self, comment: "")
	}
}
