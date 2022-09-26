//
//  SATResultViewController.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import UIKit

class SATResultViewController: UIViewController {
	
	var schoolId = ""
	private var viewModel = SATResultViewModel()
	@IBOutlet var indicatorView: UIActivityIndicatorView!
	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var noDataLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.delegate = self
		indicatorView.startAnimating()
		viewModel.fetchSATResults(schoolId: schoolId)
	}
	
	private enum CellIdentifiers {
		static let satResultCellView = "SATResultCellView"
	}
}

extension SATResultViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.dataDictionary.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.satResultCellView, for: indexPath) as! SatResultCellView
		guard let keyValuePair = viewModel.dataDictionary.first(where: { $1.displayIndex == indexPath.row }) else {
			fatalError()
		}
		cell.configure(keyValuePair.key, keyValuePair.value.value)
		return cell
	}
}

extension SATResultViewController: SATResultViewDelegate, AlertDisplayer {
	func satResultFetched() {
		DispatchQueue.main.async { [weak self] in
			guard let strongSelf = self else { return }
			strongSelf.indicatorView.stopAnimating()
			guard strongSelf.viewModel.dataDictionary.count > 0 else {
				strongSelf.noDataLabel.isHidden = false
				return
			}
			strongSelf.tableView.reloadData()
		}
	}
	
	func handle(error: AppError) {
		DispatchQueue.main.async { [weak self] in
			guard let strongself = self else { return }
			strongself.indicatorView.stopAnimating()
			let title = "Error!".localizedString
			let action = UIAlertAction(title: "OK".localizedString, style: .default)
			strongself.displayAlert(with: title , message: error.description, actions: [action])
		}
	}
}
