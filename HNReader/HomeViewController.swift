//
//  HomeViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 1/28/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	// outlets
	@IBOutlet weak var storiesTableView: UITableView!
	
	// data
	let FirebaseRef = "https://hacker-news.firebaseio.com/v0/"
	var indicator = UIActivityIndicatorView()
	var topStories:[Story] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.addActivityIndicator()
		
		indicator.startAnimating()
		indicator.backgroundColor = UIColor.white
		
		APIController.getTopStories() { stories in
			self.indicator.stopAnimating()
			self.indicator.hidesWhenStopped = true
			
			self.topStories = stories
			self.storiesTableView.reloadData()
			self.storiesTableView.estimatedRowHeight = 60
			self.storiesTableView.rowHeight = UITableViewAutomaticDimension
			
			return
		}
		
		self.storiesTableView.tableFooterView = UIView(frame: .zero)
    }
	
	func addActivityIndicator() {
		indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
		indicator.center = self.view.center
		self.view.addSubview(indicator)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return topStories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = storiesTableView.dequeueReusableCell(withIdentifier: "StoryRow", for: indexPath) as! StoryTableViewCell
		
		let story = topStories[indexPath.row]
		
		cell.title?.text = story.title
		cell.subtitle?.text = "by " + story.by
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.storiesTableView.deselectRow(at: indexPath, animated: true)
	}
	
    // In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (sender as? StoryTableViewCell) != nil {
			if let index = self.storiesTableView.indexPathForSelectedRow?.row {
				let storyVc = segue.destination as! StoryViewController
				storyVc.story = self.topStories[index]
			}
		}
    }
}
