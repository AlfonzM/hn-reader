//
//  CommentsViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 2/5/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
	
	var comments: [Comment] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		for comment in self.comments {
			print(comment.text)
			print("\n---\n")
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
