//
//  SatResultCellView.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import UIKit

class SatResultCellView: UITableViewCell {
	@IBOutlet var displayLabel: UILabel!
	@IBOutlet var valueLabel: UILabel!
	
	func configure(_ label: String, _ value: String) {
		displayLabel.text = label
		valueLabel.text = value
	}
}
