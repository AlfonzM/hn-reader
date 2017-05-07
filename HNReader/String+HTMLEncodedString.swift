//
//  String+HTMLEncodedString.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 5/2/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit

extension String {
	var html2AttributedString: NSAttributedString? {
		do {
//			let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 11)]
			
			return try NSMutableAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
		} catch {
			print(error)
			return nil
		}
	}
	var html2String: String {
		return html2AttributedString?.string ?? ""
	}
}
