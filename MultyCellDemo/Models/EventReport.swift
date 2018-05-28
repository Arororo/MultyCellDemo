//
//  EventReport.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-24.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit
import MapKit

enum EventReportType: Int {
	case map
	case collection
	case image
	
	static func allCases() -> [EventReportType] {
		var value = 0
		var result = [EventReportType]()
		var itemCandidate = EventReportType(rawValue: value)
		while let item = itemCandidate {
			result.append(item)
			value += 1
			itemCandidate = EventReportType(rawValue: value)
		}
		return result
	}
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
