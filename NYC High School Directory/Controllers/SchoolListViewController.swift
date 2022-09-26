//
//  SchoolListViewController.swift
//  NYC High School Directory
//
//  Created by Avinash Dongarwar on 9/25/22.
//

import UIKit

class SchoolListViewController: UIViewController {
	private var viewModel = SchoolsListViewModel()
	@IBOutlet private var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.delegate = self
		viewModel.fetchSchoolList()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == SegueIdentifiers.showSATResultsView.rawValue,
		   let destination = segue.destination as? SATResultViewController {
			if let cell = sender as? UITableViewCell,
			   let indexPath = tableView.indexPath(for: cell) {
				let schoolId = viewModel.schoolCellModels[indexPath.row].schoolId
				destination.schoolId = schoolId
			}
		}
	}
	
	private enum CellIdentifiers {
		static let schoolListCellView = "SchoolListCellView"
		static let loadingCellView = "LoadingCellView"
	}
	
	private enum SegueIdentifiers: String {
		case showSATResultsView = "showSATResultsView"
	}
}

extension SchoolListViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return viewModel.currentCount
		} else if section == 1 {
				// Return the Loading cell
			return 1
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.schoolListCellView, for: indexPath) as! SchoolListCellView
			cell.configure(with: viewModel.schoolCellModels[indexPath.row])
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingCellView, for: indexPath) as! LoadingCell
			cell.showLoading(viewModel.isFetchInProgress)
			return cell
		}
	}
}

extension SchoolListViewController: UITableViewDataSourcePrefetching {
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		if indexPaths.contains(where: isLoadingCell) {
			viewModel.fetchSchoolList()
		}
	}
}

extension SchoolListViewController: SchoolsListViewDelegate, AlertDisplayer {
	
	func schoolListUpdated(with newIndexPathsToReload: [IndexPath]) {
		DispatchQueue.main.async { [weak self] in
			guard let strongself = self else { return }
			guard !newIndexPathsToReload.isEmpty else {
				strongself.tableView.reloadData()
				return
			}
			strongself.tableView.insertRows(at: newIndexPathsToReload, with: .automatic)
		}
	}
	
	func handle(error: AppError) {
		DispatchQueue.main.async { [weak self] in
			let title = "Error!".localizedString
			let action = UIAlertAction(title: "OK".localizedString, style: .default)
			self?.displayAlert(with: title , message: error.description, actions: [action])
		}
	}
}

private extension SchoolListViewController {
	func isLoadingCell(for indexPath: IndexPath) -> Bool {
		return indexPath.row >= viewModel.currentCount - 1
	}
}
