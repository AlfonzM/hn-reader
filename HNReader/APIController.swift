//
//  APIController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 1/28/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIController {
	static let HN_BASE_URL = "https://hacker-news.firebaseio.com/v0/"
	static let ALGOLIA_BASE_URL = "https://hn.algolia.com/api/v1/"
	
	static func getTopStories(callback: @escaping ([Story]) -> Void) {
		Alamofire.request(HN_BASE_URL + "topstories.json").responseJSON { response in
			
			let storyIdsJson = JSON(response.result.value!)
			var storiesDict:[Int: Story] = [:]
			
			let storiesDispatchGroup = DispatchGroup()
			
			let topStoriesToDisplay = 10
			
			// initialize the dictionary of stories
			// this is to save the order of ids
			for i in 0..<topStoriesToDisplay {
				let storyId = storyIdsJson[i].intValue
				storiesDict[storyId] = Story(jsonData: JSON.null)
			}
			
			// loop through all ids and fetch each story
			for i in 0..<topStoriesToDisplay {
				
				storiesDispatchGroup.enter()
				
				let storyId = storyIdsJson[i].intValue
				
				self.getStory(storyId: storyId) { story in
					storiesDict[storyId] = story
					storiesDispatchGroup.leave()
				}
			}
			
			// finished loading all stories
			storiesDispatchGroup.notify(queue: DispatchQueue.main, execute: {
				callback(Array(storiesDict.values))
			})
		}
	}
	
	static func getItem(itemId: Int, callback: @escaping(Any?) -> Void) {
		Alamofire.request(ALGOLIA_BASE_URL + "items/\(itemId)").responseJSON { response in
			let responseJson = JSON(response.result.value!)
			var item: Any?
			
			switch(responseJson["type"]) {
				case "story":
				item = Story(jsonData: responseJson)
				
//				case "comment":
//				item = Comment(jsonData: responseJson)
				
				default:
				item = nil
			}
			
			callback(item)
		}
	}
	
	static func getComments(storyId: Int, callback: @escaping ([Comment]) -> Void) {
		Alamofire.request(ALGOLIA_BASE_URL + "items/\(storyId)").responseJSON { response in
			
			switch response.result {
			case .success(let value):
				let responseJson = JSON(value)
				
				var comments: [Comment] = []
				
				for (_,commentJson):(String, JSON) in responseJson["children"] {
					comments.append(Comment(jsonData: commentJson))
				}
				
				callback(comments)
				
			case .failure(let error):
				print(error)
			}
		}
	}
	
	static func getStory(storyId: Int, callback: @escaping(Story?) -> Void) {
		self.getItem(itemId: storyId) { item in
			if let story = item as? Story {
				callback(story)
			} else {
				callback(nil)
			}
		}
	}
	
	static func getComment(commentId: Int, callback: @escaping(Comment?) -> Void) {
		self.getItem(itemId: commentId) { item in
			if let comment = item as? Comment {
				callback(comment)
			} else {
				callback(nil)
			}
		}
	}
}
