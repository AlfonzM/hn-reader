//
//  Story.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 1/29/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import SwiftyJSON

class Story: Item {
	
	var comments: [Comment]?
	
	override init(jsonData: JSON) {
		self.comments = nil
		super.init(jsonData: jsonData)
	}
	
	func getComments(callback: @escaping ([Comment]) -> Void) {
		if self.comments != nil {
			return
		}
		
		self.comments = []
		
		print("Getting comments...")
		let commentsDispatchGroup = DispatchGroup()
		
		for commentId in self.kids {
			commentsDispatchGroup.enter()
			
			APIController.getComment(commentId: commentId) { comment in
				if comment != nil {
					self.comments!.append(comment!)
				}
				
				commentsDispatchGroup.leave()
			}
		}
		
		// finished loading all comments
		commentsDispatchGroup.notify(queue: DispatchQueue.main, execute: {
			print("Finished loading \(self.comments?.count) comments")
			callback(self.comments!)
		})
	}
}
