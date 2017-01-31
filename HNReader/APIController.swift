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
	static let BASE_URL = "https://hacker-news.firebaseio.com/v0/"
	
	static func getTopStories(callback: @escaping ([Story]) -> Void) {
		Alamofire.request(BASE_URL + "topstories.json").responseJSON { response in
			
			let storyIdsJson = JSON(response.result.value!)
			var storiesDict:[Int: Story] = [:]
			
			let storiesDispatchGroup = DispatchGroup()
			
			let topStoriesToDisplay = 10
			
			// initialize the dictionary of stories
			// this is to save the order of ids
			for i in 0..<topStoriesToDisplay {
				let storyId = storyIdsJson[i].intValue
				storiesDict[storyId] = Story(storyJson: JSON.null)
			}
			
			// loop through all ids and fetch each story
			for i in 0..<topStoriesToDisplay {
				print("Downloading \(i+1) / \(topStoriesToDisplay)")
				
				storiesDispatchGroup.enter()
				
				let storyId = storyIdsJson[i].intValue
				
				Alamofire.request(BASE_URL + "item/\(storyId).json").responseJSON { response in
					storiesDict[storyId] = Story(storyJson: JSON(response.result.value!))
					storiesDispatchGroup.leave()
				}
			}
			
			// finished loading all stories
			storiesDispatchGroup.notify(queue: DispatchQueue.main, execute: {
				print("Finished loading all stories")
				callback(Array(storiesDict.values))
			})
		}
	}
}
