//
//  CollectionCellFooter.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-25.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit

class CollectionCellFooter: UIView {
	@IBOutlet weak var collectionView: UICollectionView!
	var collectionItems: [CollectionItem]?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.setupCollectionView()
		
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 375, height: 120)
	}
	
	private func setupCollectionView() {
		let cellClassName = String(describing: ImageCollectionViewCell.self)
		let nib = UINib(nibName: cellClassName, bundle: nil)
		self.collectionView.register(nib, forCellWithReuseIdentifier: cellClassName)
	}
	
	func configure(withCollectionItems collectionItems: [CollectionItem]) {
		self.collectionItems = collectionItems
		self.collectionView.reloadData()
	}

}

extension CollectionCellFooter: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collectionItems?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = String(describing: ImageCollectionViewCell.self)
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
		if let result = cell as? ImageCollectionViewCell, let collectionItems = self.collectionItems {
			result.configure(withItem: collectionItems[indexPath.row])
			return result
		}
		return UICollectionViewCell()
	}
}

extension CollectionCellFooter: CellFooter {
	func configure(with eventReport: EventReport) {
		if let items = eventReport.collectionItems {
			self.configure(withCollectionItems: items)
		}
	}
}
