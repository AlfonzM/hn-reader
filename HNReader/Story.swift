//
//  Story.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 1/29/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import SwiftyJSON

class Story: Item {
	var url: String!
	var title: String!
	var comments: [Comment]?
	
	override init(jsonData: JSON) {
		self.comments = nil
		self.url = jsonData["url"].stringValue
		self.title = jsonData["title"].stringValue
		super.init(jsonData: jsonData)
	}
	
//	func getComments(callback: @escaping ([Comment]) -> Void) {
//		if self.comments != nil {
//			return
//		}
//		
//		self.comments = []
//		
//		print("Getting comments...")
//		let commentsDispatchGroup = DispatchGroup()
//		
//		let maxCommentsToGet = 10
//		
//		for (i, commentId) in self.kids.enumerated() {
//			if i > maxCommentsToGet {
//				break
//			}
//			
//			commentsDispatchGroup.enter()
//			
//			APIController.getComment(commentId: commentId) { comment in
//				if comment != nil {
//					self.comments!.append(comment!)
//				}
//				
//				commentsDispatchGroup.leave()
//			}
//		}
//		
//		// finished loading all comments
//		commentsDispatchGroup.notify(queue: DispatchQueue.main, execute: {
//			print("Finished loading \(self.comments?.count) comments")
//			callback(self.comments!)
//		})
//	}
}
