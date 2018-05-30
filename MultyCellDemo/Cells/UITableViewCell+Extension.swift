//
//  UITableViewCell+Extension.swift
//  MultyCellDemo
//
//  Created by Dmitry Babenko on 2018-05-28.
//  Copyright © 2018 Dmitry Babenko. All rights reserved.
//

import UIKit

extension UITableViewCell {
	
	static func nibName() -> String {
		return String(describing: self)
	}
	
	static func defaultIdentifier() -> String {
		return self.nibName()
	}
	
	@objc class func identifier(for item: Any?) -> String {
		return self.defaultIdentifier()
	}
	
	@objc class func identifiers() -> [String] {
		return [self.defaultIdentifier()]
	}
	
	@objc class func registerNibs(in tableView: UITableView) {
		let nib = UINib(nibName: self.nibName(), bundle: nil)
		self.identifiers().forEach {
			tableView.register(nib, forCellReuseIdentifier: $0)
		}
	}
}
