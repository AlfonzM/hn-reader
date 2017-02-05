//
//  StoryViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 1/29/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

	var story:Story?
	@IBOutlet weak var webView: UIWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = self.story!.title
		
		webView.loadRequest(URLRequest(url: URL(string: self.story!.url)!))
		
		self.story?.getComments() { comments in }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
	}
	
	// prepare segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "StoryToComments" {
			let commentVc = segue.destination as! CommentsViewController
			commentVc.comments = self.story!.comments!
		}
	}
}
