//
//  CommentsWebViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 4/18/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class CommentsWebViewController: UIViewController {

	@IBOutlet weak var commentsWebView: UIWebView!
	var url:String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if self.url != "" {
			commentsWebView.loadRequest(URLRequest(url: URL(string: self.url)!))
		}
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
