//
//  Item.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 2/5/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import Foundation
import SwiftyJSON

class Item {
	var id: Int
	var deleted: Bool
	var type: String
	var by: String
	var time: Int
	var text: String
	var dead: Bool
	var parent: Int
	var kids: [Int]
	var url: String
	var score: Int
	var title: String
	var descendants: Int
	var parts: [Int]

	init(jsonData: JSON) {
		self.id = jsonData["id"].intValue
		self.deleted = jsonData["deleted"].boolValue
		self.type = jsonData["type"].stringValue
		self.by = jsonData["by"].stringValue
		self.time = jsonData["time"].intValue
		self.text = jsonData["text"].stringValue
		self.dead = jsonData["dead"].boolValue
		self.parent = jsonData["parent"].intValue
		self.kids = jsonData["kids"].arrayValue.map { $0.int! } // convert to array int
		self.url = jsonData["url"].stringValue
		self.score = jsonData["score"].intValue
		self.title = jsonData["title"].stringValue
		self.descendants = jsonData["descendants"].intValue
		self.parts = jsonData["parts"].arrayValue.map { $0.int! } // convert to array int
	}
}
