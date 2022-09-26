//
//  LoadingCell.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import UIKit

class LoadingCell: UITableViewCell {
	@IBOutlet var indicatorView: UIActivityIndicatorView!
	
	func showLoading(_ show: Bool) {
		switch show {
			case true:
				indicatorView.startAnimating()
			case false:
				indicatorView.stopAnimating()
		}
	}
}
