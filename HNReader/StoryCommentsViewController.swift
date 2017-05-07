//
//  StoryCommentsViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 5/4/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class StoryCommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var story: Story!
	var comments: [Comment] = []
	
	var indicator = UIActivityIndicatorView()
	
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.addActivityIndicator()
		indicator.startAnimating()
		indicator.backgroundColor = UIColor.white
		
		self.tableView.register(UINib(nibName: "StoryCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "storyCommentTableCell")
		self.tableView.tableFooterView = UIView()
		self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		// Load comments
		print("Loading comments")
		APIController.getComments(storyId: self.story.id, callback: { comments in
			self.comments = comments
			self.tableView.reloadData()
			self.indicator.stopAnimating()
		})
    }
	
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.comments.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "storyCommentTableCell") as! StoryCommentTableViewCell
		
		let comment = self.comments[indexPath.item]
		
		cell.commentTextLabel.text = comment.text.html2String
		cell.usernameLabel.text = comment.by
		print(comment.by)
//		cell.timestampLabel.text = "\(comment.time)"
		
		return cell
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//	MARK: Indicator
	func addActivityIndicator() {
		indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
		indicator.center = self.view.center
		self.view.addSubview(indicator)
	}
}
