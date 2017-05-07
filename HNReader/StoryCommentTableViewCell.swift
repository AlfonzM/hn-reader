//
//  StoryCommentTableViewCell.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 5/4/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

class StoryCommentTableViewCell: UITableViewCell {

	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var timestampLabel: UILabel!
	@IBOutlet weak var commentTextLabel: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
