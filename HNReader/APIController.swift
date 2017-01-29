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
			let storiesDispatchGroup = DispatchGroup()
			
			let storiesJson = JSON(response.result.value!)
			var stories:[Story] = []
			
			let topStoriesToDisplay = 10
			
			for i in 0...(topStoriesToDisplay-1) {
				storiesDispatchGroup.enter()
				
				let storyId = storiesJson[i]
				Alamofire.request(BASE_URL + "item/\(storyId).json").responseJSON { response in
					stories.append(Story(storyJson: JSON(response)))
					storiesDispatchGroup.leave()
				}
			}
			
			// finished loading all stories
			storiesDispatchGroup.notify(queue: DispatchQueue.main, execute: {
				print("Finished loading all stories")
				for story in stories {
					print(story.title + " \(story.id)")
				}
				callback(stories)
			})
		}
	}
}
