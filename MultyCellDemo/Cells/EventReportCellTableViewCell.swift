//
//  EventReportCellTableViewCell.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-24.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit

class EventReportCellTableViewCell: UITableViewCell {
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var ratingImageView: UIImageView!
	@IBOutlet weak var eventTitleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var footerContainerView: UIView!
	
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
		self.descriptionLabel.text = eventReport.description
	}
    
}
