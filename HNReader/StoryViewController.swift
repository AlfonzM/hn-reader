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
		webView.loadRequest(URLRequest(url: URL(string: self.story!.url)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
