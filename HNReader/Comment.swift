//
//  Comment.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 2/5/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import SwiftyJSON

class Comment: Item {
	override init(jsonData: JSON) {
		super.init(jsonData: jsonData)
		print(self.text)
	}
}
