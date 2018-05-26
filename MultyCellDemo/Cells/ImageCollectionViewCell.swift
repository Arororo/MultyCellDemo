//
//  ImageCollectionViewCell.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-25.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	func configure(withItem item: CollectionItem){
		self.imageView.image = UIImage(named: item.imagePath)
		self.titleLabel.text = item.imageTitle
	}
}
