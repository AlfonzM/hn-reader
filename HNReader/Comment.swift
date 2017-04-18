//
//  Comment.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 2/5/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import Foundation
import SwiftyJSON

class Comment: Item
{
	var children : [Comment]
	
	init(jsonData: JSON, children: [Comment]) {
		self.children = children
		super.init(jsonData: jsonData)
		
		let commentsDispatchGroup = DispatchGroup()
		
		let subcommentIds = jsonData["kids"].arrayValue.map { $0.int! }
		
		for commentId in subcommentIds {
			commentsDispatchGroup.enter()

			APIController.getComment(commentId: commentId) { comment in
				if comment != nil {
					self.children.append(comment!)
				}

				commentsDispatchGroup.leave()
			}
		}
		
		// finished loading all comments
		commentsDispatchGroup.notify(queue: DispatchQueue.main, execute: {
			print("Finished loading \(self.children.count) subcomments")
		})
	}
 
	override convenience init(jsonData: JSON) {
		self.init(jsonData: jsonData, children: [Comment]())
	}
	
	func addChild(_ child : Comment) {
		self.children.append(child)
	}
	
	func removeChild(_ child : Comment) {
		self.children = self.children.filter( {$0 !== child})
	}
}
