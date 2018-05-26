//
//  ImageCellFooter.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-25.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit

class ImageCellFooter: UIView {
	@IBOutlet weak var imageView: UIImageView!
	
	
	
    private func configure(withImagePath imagePath: String?) {
		self.imageView.image = UIImage(named: imagePath ?? "")
	}
}

extension ImageCellFooter: CellFooter {
	func configure(with eventReport: EventReport) {
		self.configure(withImagePath: eventReport.imagePath)
	}
}
