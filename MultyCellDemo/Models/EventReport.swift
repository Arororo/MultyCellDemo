//
//  EventReport.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-24.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit
import MapKit

enum EventReportType {
	case map
	case collection
	case image
}

enum EventReporterRating: NSInteger {
	case none, one, two, three, four, five
	var icon: UIImage? {
		return UIImage(named: "rating\(self.rawValue)")
	}
}

struct CollectionItem {
	var imagePath: String
	var imageTitle: String
}

class EventReport {
	var eventReportType: EventReportType
	var authorName: String?
	var avatarFileName: String?
	var date: Date?
	var rating: EventReporterRating = .none
	var title: String?
	var description: String?
	var location: CLLocationCoordinate2D?
	var imagePath: String?
	var collectionItems: [CollectionItem]?
	
	init(ofType eventReportType: EventReportType) {
		self.eventReportType = eventReportType
	}
}
