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
	
	static private let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter
	}()
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
		if eventReportType.isRightFooterType(footer: self.footer) {
			print("* Found a right footer")
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
		
		print("* Made a new footer")
		
		if let footerView = footer as? UIView {
			footerView.frame = CGRect(x: 0, y: 0, width: self.footerContainerView.bounds.width, height: self.footerContainerView.bounds.height - 5.0)
			footerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			footerView.translatesAutoresizingMaskIntoConstraints = true;
			self.footerContainerView.addSubview(footerView)
			self.footer = footer
		}
		
		return footer!
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
