//
//  CommentsViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 2/5/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit
import RATreeView

class CommentsViewController: UIViewController, RATreeViewDelegate, RATreeViewDataSource {
	
	@IBOutlet weak var treeView: RATreeView!
	
	var story: Story!
	var comments: [Comment] = []
	
	var indicator = UIActivityIndicatorView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.addActivityIndicator()
		indicator.startAnimating()
		indicator.backgroundColor = UIColor.white
		
		setupTreeView()
		
		// Load comments
		print("Loading comments")
		APIController.getComments(storyId: self.story.id, callback: { comments in
			self.comments = comments
			
			self.treeView.reloadData()
			
			// expand all comments by default
			for item in comments {
				self.treeView.expandRow(forItem: item, expandChildren: true, with: RATreeViewRowAnimationNone)
			}
			
			self.treeView.rowsCollapsingAnimation = RATreeViewRowAnimationFade
			self.treeView.rowsExpandingAnimation = RATreeViewRowAnimationFade
			
			self.indicator.stopAnimating()
		})
    }
	
	// Setup TreeView
	func setupTreeView() -> Void {
//		treeView = RATreeView(frame: view.bounds)
		treeView.register(UINib(nibName: String(describing: CommentTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommentTableViewCell.self))
		treeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		treeView.rowsCollapsingAnimation = RATreeViewRowAnimationNone
		treeView.rowsExpandingAnimation = RATreeViewRowAnimationNone
		
		treeView.delegate = self;
		treeView.dataSource = self;
		treeView.separatorStyle = RATreeViewCellSeparatorStyleNone
		treeView.treeFooterView = UIView()
		treeView.backgroundColor = .clear
		
		treeView.estimatedRowHeight = 120
		treeView.rowHeight = UITableViewAutomaticDimension
		treeView.expandsChildRowsWhenRowExpands = true
	}
	
	//MARK: RATreeView data source
	
	func treeView(_ treeView: RATreeView, numberOfChildrenOfItem item: Any?) -> Int {
		if let item = item as? Comment {
			return item.children.count
		} else {
			return self.comments.count
		}
	}
	
	func treeView(_ treeView: RATreeView, child index: Int, ofItem item: Any?) -> Any {
		if let item = item as? Comment {
			return item.children[index]
		} else {
			return comments[index] as AnyObject
		}
	}
	
	func treeView(_ treeView: RATreeView, cellForItem item: Any?) -> UITableViewCell {
		let cell = treeView.dequeueReusableCell(withIdentifier: String(describing: CommentTableViewCell.self)) as! CommentTableViewCell
		
		let comment = item as! Comment

		cell.setup(comment: comment)

		return cell
	}
	
	func treeView(_ treeView: RATreeView, didSelectRowForItem item: Any) {
		let cell = treeView.cell(forItem: item) as! CommentTableViewCell
		cell.updateCollapsed()
	}
	
	//	MARK: Indicator
	func addActivityIndicator() {
		indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
		indicator.center = self.view.center
		self.view.addSubview(indicator)
	}
}
