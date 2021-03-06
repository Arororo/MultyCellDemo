//
//  ViewController.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-24.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	lazy var items: [EventReport] = {
		return self.generateItems()
	} ()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupTableView()
		
	}

	func setupTableView() {
		let nibName = EventReportCellTableViewCell.description().components(separatedBy: ".").last!
		let nib = UINib(nibName: nibName, bundle: nil)
		self.tableView.register(nib, forCellReuseIdentifier: "EventReportCellTableViewCell")
	}

}

extension ViewController: UITableViewDelegate {
	
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "EventReportCellTableViewCell")
		guard let result = cell as? EventReportCellTableViewCell else {
			return UITableViewCell()
		}
		result.configure(with: self.items[indexPath.row])
		return result
	}
}

//MARK: - Helpers
extension ViewController {
	private func generateItems() -> [EventReport] {
		var eventReports = [EventReport]()
		var item: EventReport = {
			let eventReport = EventReport(ofType: .map)
			eventReport.authorName = "John Appleseed"
			eventReport.avatarFileName = "JohnAppleseed"
			eventReport.date = Date.init(timeInterval: -3600 * 24 * 5, since: Date())
			eventReport.rating = .three
			eventReport.title = "Planted Apple Tree"
			eventReport.description = "An apple tree had been planted today in the beautiful park!"
			eventReport.location = CLLocationCoordinate2DMake(49.276929, -123.109892)
			return eventReport
		} ()
		eventReports.append(item)
		
		item = {
			let eventReport = EventReport(ofType: .image)
			eventReport.authorName = "Jane Appleseed"
			eventReport.avatarFileName = "JaneAppleseed"
			eventReport.date = Date.init(timeInterval: -3600.0 * 24.0 * 8.5, since: Date())
			eventReport.rating = .five
			eventReport.title = "Apple Pie Bread Pudding"
			eventReport.description = "Just took the cooking course! Look what I baked as my first assignment!"
			eventReport.imagePath = "Apple-Pie-Bread-Pudding"
			return eventReport
		} ()
		eventReports.append(item)
		return eventReports
	}
}

