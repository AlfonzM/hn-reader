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

	@IBOutlet weak var storiesTableView: UITableView!
	
	var topStories:[Story] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		APIController.getTopStories() { stories in
			self.topStories = stories
			self.storiesTableView.reloadData()
			return
		}
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
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
