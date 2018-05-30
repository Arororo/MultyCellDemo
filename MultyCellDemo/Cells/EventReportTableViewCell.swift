//
//  EventReportTableViewCell.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-24.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit

protocol CellFooter: class {
	func configure(with eventReport: EventReport)
	
}

class EventReportTableViewCell: UITableViewCell {
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var ratingImageView: UIImageView!
	@IBOutlet weak var eventTitleLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var footerContainerView: UIView!
	private weak var footer: CellFooter?
	private static var footerCounter = 0
	
	static private let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter
	}()
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	private class func identifier(for eventReportType: EventReportType) -> String {
		return super.defaultIdentifier() + "\(eventReportType)"
	}

	override class func identifier(for item: Any?) -> String {
		guard let eventReport = item as? EventReport else {
			return super.defaultIdentifier()
		}
		return self.identifier(for: eventReport.eventReportType)
	}
	
	override class func identifiers() -> [String] {
		return EventReportType.allCases().map {self.identifier(for: $0)}
	}
	
	override class func registerNibs(in tableView: UITableView) {
		let nib = UINib(nibName: self.nibName(), bundle: nil)
		EventReportType.allCases().forEach { reportType in
			tableView.register(nib, forCellReuseIdentifier: self.defaultIdentifier() + "\(reportType)")
		}
	}
	
	func configure(with eventReport: EventReport) {
		self.avatarImageView.image = UIImage(named: eventReport.avatarFileName ?? "")
		self.userNameLabel.text = eventReport.authorName
		self.ratingImageView.image = eventReport.rating.icon
		self.eventTitleLabel.text = eventReport.title
		self.dateLabel.text = EventReportTableViewCell.dateFormatter.string(from: eventReport.date ?? Date())
		self.descriptionLabel.text = eventReport.description
		let footer = accessFooter(ofType: eventReport.eventReportType)
		footer.configure(with: eventReport)
	}
	
	private func accessFooter(ofType eventReportType: EventReportType) -> CellFooter {
		EventReportTableViewCell.footerCounter += 1
		if eventReportType.isRightFooterType(footer: self.footer) {
			print("\(EventReportTableViewCell.footerCounter) * Found a right footer")
			return self.footer!
		}
		self.subviews
			.filter {$0 is CellFooter}
			.forEach {$0.removeFromSuperview()}
		
		var footer: CellFooter?
		switch eventReportType {
		case .map:
			let cellFooter: MapCellFooter = .fromNib()
			footer = cellFooter
		case .collection:
			let cellFooter: CollectionCellFooter = .fromNib()
			footer = cellFooter
		case .image:
			let cellFooter: ImageCellFooter = .fromNib()
			footer = cellFooter
		}
		
		print("\(EventReportTableViewCell.footerCounter) * Made a new footer")
		
		if let footerView = footer as? UIView {
			footerView.frame = CGRect(x: 0, y: 0, width: self.footerContainerView.bounds.width, height: self.footerContainerView.bounds.height)
//			footerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			footerView.translatesAutoresizingMaskIntoConstraints = false;
			self.footerContainerView.addSubview(footerView)
			self.footer = footer
			self.setupFooterConstraints()
		}
		
		return footer!
	}
	
	private func setupFooterConstraints() {
		if let footerView = footer as? UIView {
			let topConstraint = NSLayoutConstraint(item: footerView, attribute: .top, relatedBy: NSLayoutRelation.equal,
												   toItem: self.footerContainerView, attribute: .top, multiplier: 1.0, constant: 0)
			let bottomConstraint = NSLayoutConstraint(item: footerView, attribute: .bottom, relatedBy: NSLayoutRelation.equal,
													  toItem: self.footerContainerView, attribute: .bottom, multiplier: 1.0, constant: -5.0)
			let leftConstraint = NSLayoutConstraint(item: footerView, attribute: .left, relatedBy: NSLayoutRelation.equal,
													toItem: self.footerContainerView, attribute: .left, multiplier: 1.0, constant: 0)
			let rightConstraint = NSLayoutConstraint(item: footerView, attribute: .right, relatedBy: NSLayoutRelation.equal,
													toItem: self.footerContainerView, attribute: .right, multiplier: 1.0, constant: 0)
			let footerHeight = footerView.intrinsicContentSize.height
			let heightConstraint = NSLayoutConstraint(item: footerView, attribute: .height, relatedBy: NSLayoutRelation.equal,
													 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: footerHeight)
			footerView.addConstraint(heightConstraint)
			self.footerContainerView.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
		}
	}
}

extension EventReportType {
	func isRightFooterType(footer: CellFooter?) -> Bool {
		guard let footer = footer else {
			return false
		}
		switch self {
		case .map:
			return footer is MapCellFooter
		case .collection:
			return footer is CollectionCellFooter
		case .image:
			return footer is ImageCellFooter
		}
	}
}

extension UIView {
	class func fromNib<T: UIView>() -> T {
		return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
	}
}
