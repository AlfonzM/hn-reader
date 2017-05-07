//
//  TreeTableViewCell.swift
//  RATreeViewExamples
//
//  Created by Rafal Augustyniak on 22/11/15.
//  Copyright © 2015 com.Augustyniak. All rights reserved.
//

import UIKit

class CommentTableViewCell : UITableViewCell {
	var collapsed: Bool = false
	
	@IBOutlet weak var usernameLeadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var usernameTextLabel: UILabel!
	@IBOutlet weak var commentTextLabel: UILabel!
	
	override func awakeFromNib() {
		selectedBackgroundView? = UIView()
		selectedBackgroundView?.backgroundColor = .clear
	}
	
//	override func prepareForReuse() {
//		self.setNeedsUpdateConstraints()
//		super.prepareForReuse()
//	}
	
	func setup(comment: Comment) {
		usernameLeadingConstraint.constant = CGFloat(comment.level) * 16
		
		usernameTextLabel.text = comment.by
		
		commentTextLabel.text = comment.text.html2String.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	func updateCollapsed() {
		collapsed = !collapsed
	}
}
