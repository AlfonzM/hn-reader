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
	var children : [Comment] = []
	var level: Int = 1
	
	override init(jsonData: JSON){
		super.init(jsonData: jsonData)
		level = (jsonData["level"].intValue != 0) ? jsonData["level"].intValue : 1
		
		// Recursion for sub-comments
		for (_,commentJson):(String, JSON) in jsonData["children"] {
			let child = Comment(jsonData: commentJson, level: level + 1)
			self.addChild(child)
		}
	}
	
	convenience init(jsonData: JSON, level: Int){
		var jsonDataWithLevel = jsonData
		jsonDataWithLevel["level"] = JSON(level)
		self.init(jsonData: jsonDataWithLevel)
	}
	
//	init(jsonData: JSON, children: [Comment]) {
//		self.children = children
//		super.init(jsonData: jsonData)
//		
//		let commentsDispatchGroup = DispatchGroup()
//		
//		let subcommentIds = jsonData["kids"].arrayValue.map { $0.int! }
//		
//		for commentId in subcommentIds {
//			commentsDispatchGroup.enter()
//
//			APIController.getComment(commentId: commentId) { comment in
//				if comment != nil {
//					self.children.append(comment!)
//				}
//
//				commentsDispatchGroup.leave()
//			}
//		}
//		
//		// finished loading all comments
//		commentsDispatchGroup.notify(queue: DispatchQueue.main, execute: {
//			print("Finished loading \(self.children.count) subcomments")
//		})
//	}
	
	func addChild(_ child : Comment) {
		self.children.append(child)
	}
	
	func removeChild(_ child : Comment) {
		self.children = self.children.filter( {$0 !== child})
	}
}


extension String{
	func htmlAttributedString() -> NSAttributedString? {
		guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
		guard let html = try? NSMutableAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil) else { return nil }
		return html
	}
}
