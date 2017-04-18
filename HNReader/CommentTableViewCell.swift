//
//  TreeTableViewCell.swift
//  RATreeViewExamples
//
//  Created by Rafal Augustyniak on 22/11/15.
//  Copyright © 2015 com.Augustyniak. All rights reserved.
//

import UIKit

class CommentTableViewCell : UITableViewCell {	
	@IBOutlet private weak var commentTextLabel: UILabel!
	
	override func awakeFromNib() {
		selectedBackgroundView? = UIView()
		selectedBackgroundView?.backgroundColor = .clear
	}
	
	var additionButtonActionBlock : ((CommentTableViewCell) -> Void)?;
	
	func setup(text: String, detailsText: String, level : Int) {
		//		commentTextLabel.text = "LEVEL \(level) — \(text)"
		
		let left = 10.0 * CGFloat(level)
		self.commentTextLabel.frame.origin.x = left
		
		commentTextLabel.text = "\(left) \(text)"
		self.layoutIfNeeded()
	}
	
	func additionButtonTapped(_ sender : AnyObject) -> Void {
		if let action = additionButtonActionBlock {
			action(self)
		}
	}
	
}
