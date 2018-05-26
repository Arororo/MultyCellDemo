//
//  MapCellFooter.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-25.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit
import MapKit

class MapCellFooter: UIView {
	@IBOutlet weak var mapView: MKMapView!
	
	func configure(withCoordinates coordinates: [CLLocationCoordinate2D]) {
		self.mapView.removeAnnotations(self.mapView.annotations)
		coordinates.forEach {[weak self] coordinate in
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			self?.mapView.addAnnotation(annotation)
		}
		if let location = coordinates.first {
			let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
			self.mapView.setRegion(region, animated: false)
		}
	}
}

extension MapCellFooter: CellFooter {
	func configure(with eventReport: EventReport) {
		if let location = eventReport.location {
			self.configure(withCoordinates: [location])
		}
	}
}
