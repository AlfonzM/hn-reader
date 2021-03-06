//
//  StoryViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 1/29/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

	var story:Story!
	@IBOutlet weak var webView: UIWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = self.story.title
		
		print(self.story.id)
		
		webView.loadRequest(URLRequest(url: URL(string: self.story.url)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
	}
	
	// prepare segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "StoryToComments" {
			let commentVc = segue.destination as! CommentsViewController
			commentVc.story = self.story
//			commentVc.comments = self.story.comments ?? []
		} else if segue.identifier == "StoryToCommentsWeb" {
			let commentWebVc = segue.destination as! CommentsWebViewController
			
			commentWebVc.url = "https://news.ycombinator.com/item?id=\(self.story.id)"
		} else if segue.identifier == "StoryToStoryComments" {
			let storyCommentsVc = segue.destination as! StoryCommentsViewController
			
			storyCommentsVc.story = self.story
		}
	}
}
