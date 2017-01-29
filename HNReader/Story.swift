//
//  Story.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 1/29/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import SwiftyJSON

class Story {
	var by: String
	var descendants: Int
	var id: Int
	var kids: [Any]
	var score: Int
	var time: Int
	var title: String
	var type: String
	var url: String
	
	init(storyJson: JSON) {
		print("NEW " + storyJson["by"].stringValue)
		self.by = storyJson["by"].stringValue
		self.descendants = storyJson["descendants"].intValue
		self.id = storyJson["id"].intValue
		self.kids = storyJson["kids"].arrayValue
		self.score = storyJson["score"].intValue
		self.time = storyJson["time"].intValue
		self.title = storyJson["title"].stringValue
		self.type = storyJson["type"].stringValue
		self.url = storyJson["url"].stringValue
	}
}
