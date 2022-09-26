//
//  SchoolListCellView.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import UIKit

class SchoolListCellView: UITableViewCell {
	@IBOutlet var nameLabel: UILabel!
	
	func configure(with school: SchoolCellModel?) {
		nameLabel.text = school?.name
	}
}
